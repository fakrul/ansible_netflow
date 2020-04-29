# nfdump & nfsen - Ansible 

Deploy an Ubuntu instance in https://packet.net as Bare Metal server and configure nfdump (https://github.com/phaag/nfdump) and nfsen (http://nfsen.sourceforge.net/). There is optional palybook to configure PortTracker plugin.

## Requirements

1. https://packet.net account 
2. Ansible
3. Terraform v0.12 or newer

## Howto

Ensure you have ssh keys for authentication, as the deployment scripts make use of ssh key authentication.

```
ssh-keygen
cd ansible_netflow
```

Copy example terraform.tfvars.example into terraform.tfvars
Edit the following three lines in terraform.tfvars as per your configured packet.net account.
For further information on how to retrieve this information from packet.net visit [Packet API Integrations](https://support.packet.com/kb/articles/api-integrations)

```
# packet.net API key
auth_token = "<AUTH_TOKEN_FROM_PACKET.NET>

# packet.net organization ID
org_id = "<ORGANISATION_ID_FROM_PACKET.NET>"

# packet.net project UUID
project_id = "<PROJECT_UUID_FROM_PACKET_NET>"
```

There is Makefile for easy deployment. Run 

```
make deploy
```

It will deploy Ubuntu 16.04 in packet.net and install nfdump & nfsen with t1.small.x86 instances. You can get the packet.net public IPv4 address by running follwoing command:
 
```
terraform output ipv4
```

Access nfsen portal via https://ip-from-terraform/nfsen/nfsen.php

In order to remove the deployed infrastructure run the following command:
```
make destroy
```


## Optional

Run the following playbook to enable PortTracker plugins:

```
ansible-playbook nfsen-porttracker.yml -i hosts
```

