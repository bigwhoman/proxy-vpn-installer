apt install -y wget

apt install -y unzip

mkdir /etc/v2ray

cd /etc/v2ray

wget https://github.com/bigwhoman/Ansible-vpn-installer/blob/main/config.json

wget https://github.com/v2fly/v2ray-core/releases/download/v5.1.0/v2ray-linux-64.zip

unzip v2ray-linux-64.zip

rm v2ray-linux-64.zip

apt install -y jq 

./v2ray tls cert | tee cert.json 

jq -r .certificate[] < cert.json | tee cert.pam

jq -r .key[] < cert.json | tee key.pam

uuid=$(./v2ray uuid)

sed -i "s/FILL ME/$uuid/" "./config.json"

wget url -P /etc/systemd/system

wget url -P /etc/systemd/system

systemctl v2ray enable

systemctl v2ray start
