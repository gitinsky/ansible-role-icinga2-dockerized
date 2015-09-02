Eye.application 'icinga2' do
  working_dir '/'
  stdall '/var/log/eye/icinga2-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :icinga2 do
    pid_file '/var/run/icinga2-eye.pid'
    pre_start_command '/root/createdb.sh'
    start_command 'icinga2 daemon'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds
    trigger :transition, :to => :up, :from => :starting, :do => -> {
      process.execute_sync "/root/createdb.sh"
    }
  end
end
