```bash
sudo adduser kafka
sudo adduser kafka sudo
su -l kafka
mkdir ~/Downloads
curl "https://downloads.apache.org/kafka/2.8.2/kafka_2.13-2.8.2.tgz" -o ~/Downloads/kafka.tgz
mkdir ~/kafka && cd ~/kafka
tar -xvzf ~/Downloads/kafka.tgz --strip 1
nano ~/kafka/config/server.properties

delete.topic.enable = true
log.dirs=/home/kafka/logs

## Zookeper
sudo nano /etc/systemd/system/zookeeper.service
[Unit]
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
ExecStart=/home/kafka/kafka/bin/zookeeper-server-start.sh /home/kafka/kafka/config/zookeeper.properties
ExecStop=/home/kafka/kafka/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target


sudo nano /etc/systemd/system/kafka.service

[Unit]
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=kafka
ExecStart=/bin/sh -c '/home/kafka/kafka/bin/kafka-server-start.sh /home/kafka/kafka/config/server.properties > /home/kafka/kafka/kafka.log 2>&1'
ExecStop=/home/kafka/kafka/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target



sudo systemctl enable zookeeper
sudo systemctl enable kafka



sudo deluser kafka sudo
sudo passwd kafka -l
sudo su - kafka


## KafkaT
#sudo apt install ruby ruby-dev build-essential
#sudo CFLAGS=-Wno-error=format-overflow gem install kafkat
#nano ~/.kafkatcfg
#{
#  "kafka_path": "~/kafka",
#  "log_path": "/home/kafka/logs",
#  "zk_path": "localhost:2181"
#}
