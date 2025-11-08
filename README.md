# dns.home.unorthordoxdev.net

This contains my scripts for starting and running my dns servers at home. To use this, you will want to run this on two different machines, be it virtual machines, or physical. You will need docker installed. 

Because this is running DNS these machines should always be on, and have a policy configured if for some reason the machine dies or loses power, it should automatically start back up. DNS is really the back bone of the internet, and these instances can have almost 0 downtime unnoticed.

## Prerequisite

- [ ] Preferably a linux server. (Debian)
- [ ] Docker is installed.

## Getting Started

1. Clone the repo in /opt/ 
2. Run `generate_certs.sh`
3. Create a crontab job to renew the certs every day. `(crontab -l 2>/dev/null; echo "@daily $(pwd)/renew-cert.sh >> $(pwd)/cron.log 2>&1") | crontab -`
4. Copy the `SAMPLE.env` and place a password you will remember.
5. Edit /adgaurd/conf/AdGuard.yaml and update the hostname to reflect the dns name you want it to.
6. Run `docker compose up --build --force-recreate -d`
