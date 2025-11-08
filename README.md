# dns.home.unorthordoxdev.net

This contains my scripts for starting and running my dns servers at home. To use this, you will want to run this on two different machines, be it virtual machines, or physical. You will need docker installed. 

Because this is running DNS these machines should always be on, and have a policy configured if for some reason the machine dies or loses power, it should automatically start back up. DNS is really the back bone of the internet, and these instances can have almost 0 downtime unnoticed.

Once you have docker installed on your machine, you can clone this repo from git, and then cd into the directory. Once inside of the directory you can run the following

1. You will want to copy the SAMPLE.env to .env and place a super secret password inside of the env file. 
2. Run generate_certs.sh
3. Run the following command to check the ssl certificate.
```
(crontab -l 2>/dev/null; echo "@daily $(pwd)/renew-cert.sh >> $(pwd)/cron.log 2>&1") | crontab -
```
4. Next you will now start the container.
```
docker compose up --build --force-recreate -d
```

This will build, and recreate the docker container using all new configuration.
