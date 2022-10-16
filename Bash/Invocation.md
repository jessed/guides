## Invocation / Initialization (simplified)
This is a very simplified view of Bash initialization. Understanding Bash initialization is required to ensure that your
 custom aliases and functions are available in youru shell.

When Bash is started as an interactive login shell it reads the following files in order and executes the commands found within:
1. /etc/profile
2. ~/.bash_profile
3. ~/.bash_login
4. ~/.profile

When started as an interactive, non-login shell it only reads: *~/.bashrc*.

As you can see, none of the files are common to both start-up types. For this reason it is common to place your customiz
ation in the ~/.bashrc file, then reference that file from the ~/.profile file. It is also common to simply makes the ~/.profile file a symlink to ~/.bashrc. Either way, the ~/.bashrc file is read and executed every time Bash is started, wh
ich is the point. The alternative to this approach would be to duplicate your customizations in ~/.profile and ~/.bashrc (which would suck).

For the purpose of this guide I'm recommending that you check the ~/.profile file and if is not a symlink to ~/.bashrc,
rename it is ~/.profile.old, then symlink ~/.bashrc to ~/.profile. The commands to do this are as follows:
```
cd                          # change to your home directory
mv .profile .profile.orig   # rename .profile to .profile.orig
ln -s .bashrc .profile      # create a symlink from .bashrc to .profile
```

From this point forward your customizations will be added to ~/.bashrc, since is will be read and executed everytime Bas
h is started regardless of whether it is a login shell or not.
