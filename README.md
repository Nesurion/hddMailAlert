hddMailAlert
============

Sends an Email if HDD gets full

Useage
------
- configure config.json.example to your needs
- rename config.json.example to config.json
- set your email username and password in env variables
  - eg. ~/.bashrc `export GMAIL_USERNAME="user"` and `export GMAIL_PASSWORD="password"`
  - keep in mind that user just means user, so: user instead of user@domain.com
- i recommand adding a cronjob

License
-------
MIT
