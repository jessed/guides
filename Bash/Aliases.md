# Bash Aliases

## Definition and Usage
Bash Aliases provide a way to execute a complex command, or more than one, with a single-word command. Aliases utility is in shortening what you have to type for a given command or set of commands. Their functionality is limited, but extremely handy and should not be dismissed due to their limitations. 

Here is an example of defining an alias that will execute the command 'ls -l --color=always':
```
alias ll="ls -l --color=always"    # linux
```
After executing that command you will have a new command available: 'll'. When you execute 'll' on the command-line it will actually call 'ls -l --color=always' - a 20 character command commpressed to two characters. That is where Bash Aliases shine - shortening a long command into a much shorter version.

Aliases are capable of overwriting existing commands. For example:
```
alias ping="ping -n"
```

Now when running 'ping' the actual command that will be executed is 'ping -n', which disables name resolution. 


## Multiple commands in a single alias
It is also possible to string multiple commands together. The commands much be spearated with pipes (|) or semicolons (;). Semi-colons separate the commands with the output of each being printed to STDOUT. Here is an example of using multiple commands in a single alias, which can be useful for having multiple outputs on the screen:
```
alias ls_dirs='ls -l /etc/ssl; ls -l /etc/ssh'
```
The *ls_dirs* alias will execute 'ls -l /etc/ssl' followed by 'ls -l /etc/ssh'. 

Another, perhaps more useful example, would be to run simulatneous 'watch' commands 
```
alias get_nodes_pods="watch 'kubectl -n kube-system get pods; echo; kubectl get nodes'"
```
The *get_nodes_pods* alias will run the 'watch' command with the arguments shown 'kubectl -n kube-system get pods; echo; kubectl get nodes'. This command will continually output 'kubectl -n kube-system get pods; echo; kubectl get nodes'. The 'echo' command in the middle only serves to output a blank line to separate the output of the two kubectl commands.

## Examples
Here are a few Bash aliases I use on a not infrequent basis. I've separated the aliases by subject and/or operating system (as appropriate):

### Common (Linux)
```
alias ls='ls --color=always'
alias ll='ls -l --color=always'
alias l1='ls -1 --color=always'
alias lh='ls -lh --color=always'
alias la='ls -lA --color=always'
alias ld='ls -ld --color=always'
alias mv='mv -i'                                    # Because I'm becoming a coward...
alias cp='cp -i'                                    # Because I'm still a coward
alias s='sudo -E '                                  # The space after '-E' tells sudo that there additional arguments
alias svim='sudo vim '                              # The space after '-E' tells sudo that there additional arguments
alias duh='du -hd 1'                                # disk space used by current directory + one sub-directory level
alias last='last | head -20'
alias grep='grep -i --color=auto -E'                # Colorize grep output, enable regex matching
alias sctl='sudo systemctl'                         # Run 'systemctl' commands with 'sudo'
alias my_ip='curl http://icanhazip.com'             # Print my current IP address
```

### Common (Mac)
```
alias ls='ls -GP'
alias ll='ls -Gl'
alias l1='ls -G1'
alias lh='ls -Glh'
alias la='ls -GlA'
alias ld='ls -Gld'
alias mv='mv -i'
alias cp='cp -i'
alias s='sudo -E '
alias svim='sudo vim '
alias vir='vim -R'                                  # Open file in read-only mode
alias top='top -o cpu -O rsize -n30'                # The default 'top' on Mac sucks
alias duh='du -hd1'
alias ping='ping -n'                                # Don't perform name resolution when using ping
alias grep='grep --color=auto'
alias conns='netstat -anf inet'                     # Output current connection table with netstat
alias my_ip='curl http://icanhazip.com'             # get public IP
```


### apt aliases (Debian / Ubuntu distributions)
```
# Apt/pkg-mgmt aliases
alias acs='apt-cache search'
alias acsn='apt-cache search --names-only'
alias acsh='apt-cache show'
alias acsp='apt-cache showpkg'
alias sagi='sudo apt-get install'
alias sagu='sudo apt-get update'
alias sagup='sudo apt-get upgrade'
alias sagr='sudo apt-get remove'
alias sadu='sudo apt-get dist-upgrade'
alias dqry="dpkg-query -W -f='\${Package;-35}\${Version;-30}\${Status;-24}\n'"
```

