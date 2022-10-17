# startagent()
This function starts an ssh-agent using the value of $SSH_AUTH_SOCK (environment variable) as the communication socket. The function then pre-loads the keys specified in the $KEYS variable. When you connect to a remote machine SSH will attempt to authenticate you to the remote machine using each of the keys until successful.

***Note***: By default SSH will only attempt to authentication with up to five keys. If the remote host does not accept any of those keys the connection will fail. The maximum number of authentication attempts usually defaults to five (5), but can be modified by changing the 'MaxAuthTries' configuration option in the /etc/ssh/sshd_config.

```
# start the ssh-agent using whatever $SSH_AUTH_SOCK is defined
startagent() {
  if [[ -z "$SSH_AUTH_SOCK" ]]; then
    echo "ERROR: \$SSH_AUTH_SOCK not defined"
    return
  else
      KEYS="id_rsa cpt_shared.key aws_f5.pem personal_aws.key github_rsa2 cloud_f5"
      #KEYS="$KEYS jessed_secure.key git_itc.key"
    eval $(ssh-agent -a $SSH_AUTH_SOCK)
    if [ -n "$1" ]; then
      ssh-add $1
    else
      for k in $KEYS; do
        test -f ~/.ssh/${k} && ssh-add ~/.ssh/${k}
      done
      echo $SSH_AGENT_PID > ${TMPDIR}/ssh_agent_pid
    fi
  fi
}
```
