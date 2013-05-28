Facter.add(:updates) do
  setcode do
    updates = []
    if Facter.value(:lsbdistid) == "Ubuntu"
      if File.exists?('/var/lib/update-notifier/updates-available')
        update_file = File.open('/var/lib/update-notifier/updates-available')
        update_file.each_line do |line|
          line.split("\n").grep(/packages can be updated/) do |m|
            updates = m.split(" ")[0]
          end
        end
      end
    end
    updates
  end
end

Facter.add(:updates_security) do
  setcode do
    updates_security = []
    if Facter.value(:lsbdistid) == "Ubuntu"
      if File.exists?('/var/lib/update-notifier/updates-available')
        update_file = File.open('/var/lib/update-notifier/updates-available')
        update_file.each_line do |line|
          line.split("\n").grep(/updates are security updates/) do |m|
            updates_security = m.split(" ")[0]
          end
        end
      end
    end
    updates_security
  end
end
