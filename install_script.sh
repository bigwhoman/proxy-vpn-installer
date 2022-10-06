apt install -y wget

apt install -y unzip

mkdir /etc/v2ray

cd /etc/v2ray

wget https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-linux-64.zip

rm config.json

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/config.json

unzip v2ray-linux-64.zip

rm v2ray-linux-64.zip

apt install -y jq 

./v2ray tls cert | tee cert.json 

jq -r .certificate[] < cert.json | tee cert.pam

jq -r .key[] < cert.json | tee key.pam

rm cert.json

uuid=$(./v2ray uuid)

sed -i "s/FILL ME/$uuid/" "./config.json"

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/systemd/system/v2ray.service -P /etc/systemd/system

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/systemd/system/v2ray@.service -P /etc/systemd/system

ufw allow 443

ufw allow 8080

systemctl daemon-reload

systemctl enable v2ray

systemctl start v2ray
