import os
import subprocess
import yaml
from shutil import copy

KUBEFLOW_FOLDER = "manifests"
output = subprocess.check_output("locate –i *.git", shell=True)

def copy_if_not_exists(filename):
    if not os.path.isfile(full_path + "/"+filename):
        copy(filename, full_path)

for path in output.decode("utf-8").split("\n"):
    if path != "" and path.split("/")[-2] == KUBEFLOW_FOLDER:
        full_path = path.replace("/.git", "")+"/common/dex/overlays/github"
        copy_if_not_exists("main.py")
        copy_if_not_exists("create.sh")
        copy_if_not_exists("script.sh")

        with open(full_path+"/kustomization.yaml", 'r') as file:
            data_loaded = yaml.safe_load(file)
            data_loaded["configMapGenerator"].append({'name': 'dex-secret-generator',
                                                      'files': ['main.py',
                                                                'script.sh',
                                                                'create.sh']})

        with open(full_path+'/kustomization.yaml', 'w', encoding='utf8') as outfile:
            yaml.dump(data_loaded, outfile, default_flow_style=False, allow_unicode=True)

