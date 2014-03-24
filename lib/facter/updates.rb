Facter.add(:updates) do
  setcode do
    if Facter.value(:osfamily) == "Debian"
      updates = 0
      if File.exists?('/var/lib/update-notifier/updates-available')
        output = File.open('/var/lib/update-notifier/updates-available')
        if not output.nil?
          output.each_line do |line|
            updates = line.split(' ')[0] if line =~ /packages? can be updated/
          end
        else
          updates = Facter::Util::Resolution.exec('/usr/bin/apt-get -s -o Debug::NoLocking=true dist-upgrade | grep -c ^Inst')
        end
      else
        updates = Facter::Util::Resolution.exec('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade | grep -c ^Inst')
      end
      updates
    elsif Facter.value(:osfamily) == "Darwin"
      updates = Facter::Util::Resolution.exec('/usr/sbin/softwareupdate -l|grep -c "\t"')
    elsif Facter.value(:osfamily) == "windows"
      updates = 0
      output = Facter::Util::Resolution.exec('wmic qfe get')
      if not output.nil?
        output.each_line do |line|
          updates = updates + 1 if line =~ /Update/
        end
      end
      updates
    elsif Facter.value(:osfamily) == "RedHat"
      updates = Facter::Util::Resolution.exec('/usr/bin/yum list updates -q -C | grep -vc "Updated Packages"')
    elsif Facter.value(:osfamily) == "Suse"
      updates = Facter::Util::Resolution.exec('zypper --no-refresh lu --best-effort | grep -c "v |"')
    elsif Facter.value(:operatingsystem) == "Archlinux"
      updates = Facter::Util::Resolution.exec('pacman -Sup | grep -vc "^\(::\| \)"')
    end
  end
end

Facter.add(:updates_security) do
  setcode do
    if Facter.value(:osfamily) == "Debian"
      if File.exists?('/var/lib/update-notifier/updates-available')
        updates_security = 0
        output = File.open('/var/lib/update-notifier/updates-available')
        if not output.nil?
          output.each_line do |line|
            updates_security = line.split(' ')[0] if line =~ /security updates/
          end
        end
        updates_security
      end
     elsif Facter.value(:osfamily) == "RedHat"
      updates_security = 0
      output = Facter::Util::Resolution.exec('/usr/bin/yum list-sec --security -q -C 2>/dev/null | wc -l').chomp
         if not output.nil?
          updates_security = output
         end
       updates_security
     elsif Facter.value(:osfamily) == "windows"
      updates_security = 0
      output = Facter::Util::Resolution.exec('wmic qfe get')
      if not output.nil?
        output.each_line do |line|
          updates_security = updates_security + 1 if line =~ /Security Update/
        end
      end
      updates_security
    end
  end
end
