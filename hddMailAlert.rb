require 'mail'
require 'json'

config = JSON.parse(File.read 'config.json')

options = { :address              => config["address"],
            :port                 => config["port"],
            :domain               => config["domain"],
            :user_name            => ENV["GMAIL_USERNAME"],
            :password             => ENV["GMAIL_PASSWORD"],
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

spacePercent = `df -k #{config["hddMountPoint"]}`.split(/\b/)[26].to_i
spaceLeftGB = `df -k #{config["hddMountPoint"]}`.split(/\b/)[24].to_i / (1024 * 1024)

def sendMail(config, subjectText, bodyText)
        Mail.deliver do
                to config["email"]["to"]
                from config["email"]["from"]
                subject subjectText
                body bodyText
        end
        puts "hddMailAlert sent " + Time.now.to_s
end

if spacePercent >= config["criticalPercentWarningLevel"] || spaceLeftGB <= config["criticalGBWarningLevel"]
	sendMail(config, 
	"Disk is full!", 
	"Disk is full! #{spacePercent}% used, #{spaceLeftGB}GB left.")
else
	if spacePercent >= config["percentWarningLevel"] || spaceLeftGB <= config["GBWarningLevel"]
		sendMail(config,
		"Disk space running out",
		"Disk space on device is running out. #{spacePercent}% used, #{spaceLeftGB}GB left.")
	end
end

