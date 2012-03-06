require "toss/options"
require "toss/version"
require "toss/meta"
require "toss/ssh"
require "toss/color"
require "toss/server"

include Toss::Meta
include Toss::Ssh

@step_index ||= 0

def steps
  @steps ||= []
end

def step(step_name, options={})
  steps << [step_name, options]
end

def rollback_steps
  @step_index.downto(0) do |index|
    m = method(steps[index][0])
    if m.arity == -1
      puts "== " + red("Rolling Back") + " " + bwhite(cap_words(steps[index][0].to_s.gsub("_", " "))) + " =="

      if m.call(true) == false
        puts "here"
        exit(1)
      end
    end
  end
end

def cap_words(str) 
  str.split(" ").each{|word| word.capitalize!}.join(" ") 
end