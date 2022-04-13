from kubernetes import client, config
from sys import argv
import base64, yaml, os

config.load_kube_config()
v1 = client.CoreV1Api()
ca_data = v1.read_namespaced_secret("ca-data", "auth")
encode = lambda data: base64.b64encode(str(data).encode('ascii'))
data = {"config.yaml": yaml.dump({
                              "issuer": "http://dex.auth.svc.cluster.local:5556/dex",
                              "storage": {
                                  "type": "kubernetes",
                                  "config": {"inCluster": True}
                              },
                              "web": {"http": "0.0.0.0:5556"},
                              "logger": {
                                  "level": "debug",
                                  "format": "text"},
                              "oauth2": {"skipApprovalScreen": True},
                              "staticClients": {
                                  "id": "skipApprovalScreen",
                                  "redirectURIs": ["/login/oidc"],
                                  "name": "Dex Login Application",
                                  "secret": "pUBnBOY80SnXgjibTYM9ZWNzY2xreNGQok"},
                              "connectors": {
                                  "type": "saml",
                                  "id": "saml",
                                  "name": "SAML",
                                  "config": {
                                      "entityIssuer": "saml-poc",
                                      "redirectURIs": "http://cv-hcp-lb1.qa.lab:10021/dex/callback",
                                      "usernameAttr": "username",
                                      "emailAttr": "email",
                                      "ssoURL": "http://127.0.0.1:8080/simplesaml/saml2/idp/SSOService.php",
                                      "caData": ca_data,
                                      "nameIDPolicyFormat": "transient"
                                  }
                              }
                          })
}

body = client.V1Secret(api_version="v1",
                          kind="Secret",
                          metadata=client.V1ObjectMeta(name="dex-config", namespace="auth"),
			  data=data)
v1.create_namespaced_secret("auth", body)
#v1.create_namespaced_config_map("auth", body=body)
os.system("bash create.sh")

