require 'mail'
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'gmail.com',
            :user_name            => 'username',
            :password             => 'password',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

spacePercent = `df -h /dev/sdf`.split(/\b/)[24].to_i
spaceLeftGB = `df -h /dev/sdf`.split(/\b/)[22].to_i

if spacePercent >= 90 || spaceLeftGB <= 50
Mail.deliver do
       to 'to'
     from 'from'
  subject "sub"
     body "Disk space on device is running out. #{spacePercent}% used, #{spaceLeftGB}GB left.
On arival of the new disk:
     		1. Add new disk to fstab
     		2. Add new disk to hdrocker mount in rc.local
     		3. run tvDirCloner.rb
     		4. recreate symlinks
     		5. add new disk to source in xbmc - and roommates xbmc"
end
puts "hddMailAlert sent " + Time.now.to_s
end