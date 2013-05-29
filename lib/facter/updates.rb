Facter.add(:updates) do
  setcode do
    if Facter.value(:lsbdistid) == "Ubuntu"
      updates = 0
      if File.exists?('/var/lib/update-notifier/updates-available')
        update_file = File.open('/var/lib/update-notifier/updates-available')
        update_file.each_line do |line|
          if line.match(/packages? can be updated/)
            updates = line.split(' ')[0]
          else
            updates = Facter::Util::Resolution.exec('/usr/bin/apt-get -s -o Debug::NoLocking=true dist-upgrade | grep -c ^Inst')
          end
        end
      else
        updates = Facter::Util::Resolution.exec('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade | grep -c ^Inst')
      end
      updates
    elsif Facter.value(:osfamily) == "Darwin"
      updates = Facter::Util::Resolution.exec('/usr/sbin/softwareupdate -l|grep -c "\t"')
    elsif Facter.value(:osfamily) == "windows"
      updates = 0
      get_updates = IO.popen("wmic qfe get", "r")
      while line = get_updates.gets
        if line.match(/Update/)
          updates = updates + 1
        end
      end
      get_updates.close
      updates
    end
  end
end

Facter.add(:updates_security) do
  setcode do
    if Facter.value(:lsbdistid) == "Ubuntu"
      if File.exists?('/var/lib/update-notifier/updates-available')
        updates_security = 0
        update_file = File.open('/var/lib/update-notifier/updates-available')
        update_file.each_line do |line|
          if line.match(/security updates/)
            updates_security = line.split(' ')[0]
          end
        end
        updates_security
      end
    elsif Facter.value(:osfamily) == "windows"
      updates_security = 0
      get_updates = IO.popen("wmic qfe get", "r")
      while line = get_updates.gets
        if line.match(/Security Update/)
          updates_security = updates + 1
        end
      end
      get_updates.close
      updates
    end
  end
end
