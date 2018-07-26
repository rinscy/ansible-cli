# Ansible Client

A simple container with [ansible] installed, ready to use.


## Usage

```sh
docker run --rm -it \
       -v ansible_playbook_sources_path:/home/ansible/sources \
       rinscy/ansible-cli:1.0
```


## Note
[Ansible] in version 2.5.5
Python3, pip3 also installed.

[ansible]: <http://docs.ansible.com>
[github]: <https://github.com/rinscy>
