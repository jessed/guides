# synckey()
This function copies the public key you specify (third argument) to the host you specify (first argument) using the username you specify (second argument). If the user is not specified it defaults to 'root'. If the public key is not specified it defaults to '~/.ssh/id_rsa.pub'.
```
# send the specified public key to the ~/.ssh/authorized_keys file on the remote host
# SYNTAX:       synckey <host> [user] [/path/to/public/key]
# default user: root
# default pub:  ~/.ssh/id_rsa.pub
synckey() {
  if [[ -z "$1" ]]; then
    echo "USAGE: synckey <hostname> [username] [pub key file]";
    echo "Defaults to adding the contents of ~/.ssh/cpt_shared.pub"
    echo "to ~/.ssh/authorized_keys on the remote system"
    return
  else
    HOST=$1
  fi
  if [ -z "$2" ]; then USER=root; else USER=$2; fi
  if [ -z "$3" ]; then KEY="$HOME/.ssh/id_rsa.pub"; else KEY=$3; fi

  KEYS=$(cat $KEY)
  ssh ${USER}@${HOST} "echo $(< $KEY) >> ~/.ssh/authorized_keys"
}
```

