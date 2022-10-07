apt install -y wget

apt install -y unzip

mkdir /etc/v2ray

cd /etc/v2ray

wget https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-linux-64.zip

unzip v2ray-linux-64.zip

rm config.json

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/v2ray/config.json

rm v2ray-linux-64.zip

apt install -y jq 

./v2ray tls cert | tee cert.json 

jq -r .certificate[] < cert.json | tee cert.pam

jq -r .key[] < cert.json | tee key.pam

rm cert.json

uuid=$(./v2ray uuid)

sed -i "s/FILL ME/$uuid/" "./config.json"

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/v2ray/systemd/system/v2ray.service -P /etc/systemd/system

wget https://raw.githubusercontent.com/bigwhoman/Ansible-vpn-installer/main/v2ray/systemd/system/v2ray@.service -P /etc/systemd/system

ufw allow 443

ufw allow 8080

systemctl daemon-reload

systemctl enable v2ray

systemctl start v2ray

wget https://raw.githubusercontent.com/bigwhoman/proxy-vpn-installer/main/v2ray/v2ray_vmess_client_config.json -P ~

wget https://raw.githubusercontent.com/bigwhoman/proxy-vpn-installer/main/v2ray/qr.json -P ~

cd ~

apt install -y ifconfig

ip_var=$(hostname -I | awk '{print $1}')

sed -i "s/SERVER_IP/$ip_var/" "./v2ray_vmess_client_config.json"

sed -i "s/SERVER_IP/$ip_var/" "./qr.json"

sed -i "s/SERVER_UUID/$uuid/" "./v2ray_vmess_client_config.json"

sed -i "s/SERVER_UUID/$uuid/" "./qr.json"

apt install -y qrencode 

#qrencode -t ansiutf8 "$(cat qr.json)"