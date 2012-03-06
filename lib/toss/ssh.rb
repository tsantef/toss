require "net/ssh"
require "net/scp"

module Toss
  module Ssh
    module ClassMethods
    end
    
    module InstanceMethods
      def open_sessions
        @open_sessions ||= {}
      end

      def start_session(server)
        puts "Starting ssh session to #{server.host}"
        open_sessions[server.host] = Net::SSH.start(server.host, server.user, :password => server.password)
        open_sessions[server.host]
      end

      def close_sessions
        open_sessions.each.each do |target_host,session|
          puts "Closing ssh session for #{target_host}"
          session.close
          open_sessions.delete(target_host)
        end
      end

      def ssh_exec!(ssh, command)
        stdout_data = ""
        stderr_data = ""
        exit_code = nil
        exit_signal = nil
        ssh.open_channel do |channel|
          channel.exec(command) do |ch, success|
            unless success
              abort "FAILED: couldn't execute command (ssh.channel.exec)"
            end
            channel.on_data do |ch,data|
              stdout_data+=data
            end

            channel.on_extended_data do |ch,type,data|
              stderr_data+=data
            end

            channel.on_request("exit-status") do |ch,data|
              exit_code = data.read_long
            end

            channel.on_request("exit-signal") do |ch, data|
              exit_signal = data.read_long
            end
          end
        end
        ssh.loop
        [stdout_data, stderr_data, exit_code, exit_signal]
      end      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end