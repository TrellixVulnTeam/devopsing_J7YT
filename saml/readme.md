# Saml automatisator

Easy to use scripts to enable saml authorization

- Run installer.py
- Add job to cluster
- See enabled sso authorization
- ✨Magic ✨

## Requirments
- running saml service
- running cluster
- python3

## Usage
- run installer.py
- also before kubeflow installation you can configure(or leave default, for more info check **algorithm**) python file main.py in *manifests/common/dex/overlays/github*
- add to cluster job generateDexConfig.yaml (*/saml*)

## Algorithm
- installer prepares workaround
- kustomize mounts scripts into container;
- job starts scripts.sh, which gets certificate data, encodes it, passes to secret caData and starts main.py; certificate data is placed [here](http://10.234.238.56:8080/simplesaml/saml2/idp/metadata.php) in tag <ds:X509Certificate>; if it shows nothing, check your saml service status and configure where exactly you retrieve data in given script;
- main.py script uses secret caData and hardcoded data to create secret with configuration for dex and after starts create.sh;  default config:
```python 
v1.create_namespaced_secret("auth",
                                client.V1Secret(api_version="v1",
                                                kind="Secret",
                                                metadata=client.V1ObjectMeta(name="dex-config", namespace="auth"),
                                                type="Opaque",
                                                data={
                                                    "config.yaml": encode(yaml.dump({
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
                                                                 v1.create_namespaced_secret("auth",
                                client.V1Secret(api_version="v1",
                                                kind="Secret",
                                                metadata=client.V1ObjectMeta(name="dex-config", namespace="auth"),
                                                type="Opaque",
                                                data={
                                                    "config.yaml": encode(yaml.dump({
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
                                                            }}))}))
"nameIDPolicyFormat": "transient"
                                                            }
                                                            }}))}))
```
- create.sh gets config from secret and applies config to cluster
          
## Troubleshooting
main.py gives all the information about mistakes, check requirements, see if all packages needed loaded
