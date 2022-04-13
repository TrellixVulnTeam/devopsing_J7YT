sudo apt install xmlstarlet
if [ $# -eq 0 ]
  then url="http://127.0.0.1:8080/simplesaml/saml2/idp/metadata.php"
elif [ $# -eq 1 ]
  then url=$1
else
  tput setaf 1
  echo "Please provide one or no args"
  tput sgr0
  exit
fi

curl $url -o metadata.xml
data=$(xmlstarlet sel -t -m '//ds:X509Certificate[1]' -v . -n <metadata.xml)
rm metadata.xml
data="-----BEGIN CERTIFICATE-----$data-----END CERTIFICATE-----"

sudo apt install python3
sudo apt install python3-pip
pip3 install kubernetes

newdata=$(base64 <<< $data)

kubectl create secret generic ca-data --from-literal=data="$newdata" -n auth
python3 main.py

