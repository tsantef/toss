def server(properties)
  return Server.new(properties)
end

def with(obj, &block)
  obj.instance_eval &block
end

class Server

  attr_accessor :host, :user, :password, :type
  attr_accessor :working_directory
  attr_accessor :ssh

  def initialize(properties)
    @host = properties[:host]
    @user = properties[:user]
    @password = properties[:password]
    @type = properties[:type]
  end

  def run(command='', &block)
    if block_given?
      self.instance_eval &block
    else
      result = exec(command, false)
      return result.first
    end
  end

  def exec(command, quiet=false)
    ssh = open_sessions[host] || start_session(self) 
    # capture all stderr and stdout output from a remote process

    if $options[:verbose] 
      puts "#{bwhite host} executing: #{command}"
    end

    if !working_directory.nil? && working_directory != ""
      command = "cd #{working_directory} && " + command
    end

    stdout_data, stderr_data, exit_code, exit_signal = ssh_exec! ssh, command

    if !quiet
      puts "#{bwhite host} said: #{red stderr_data.strip!}" if !stderr_data.nil? && stderr_data != ""
      puts "#{bwhite host} said: #{stdout_data.strip!}" if !stdout_data.nil? && stdout_data != ""
    end

    return exit_code, stdout_data, stderr_data, exit_signal
  end

  def exists?(path)
    exit_code = run("[ -e #{path} ] && exit 0 || exit 1")
    return exit_code == 0
  end

  def cd(path)
    if $options[:verbose] 
      puts "#{bwhite host} cd to: #{path}"
    end
    if block_given?
      previous_path = @working_directory
      @working_directory = path
      yield
      @working_directory =  previous_path
    else
      @working_directory = path
    end
  end

  def delete(path)
    if exists? "#{path}"
      return run "unlink #{path}"
    end
  end

end