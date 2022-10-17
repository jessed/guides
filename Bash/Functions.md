# Bash Functions

## Definition and Syntax
Bash functions are more complex than aliases because they don't just execute static commands. The code within functions can create and use variables, contain conditionals, and execute loops. They are snippets of Bash scripting code, in exactly the same way a function in a full programming language is a snippet of that languages code. They may or may be provided with arguments, execute whatever is defined, and provide output. Variables that are created *within* the function are local to that function and not available outside of it. Unlike many other languages, variables created *outside* of the function are available for use within the function - they do not need to be explicitly passed to the function. That said, the best-practice is to pass arguments into the function and avoid referencing variables outside of the function. While that is a best-practice, adhering to that approach also also makes using Bash functions more complicated than one typically wants when using Bash.

A function is defined with the following syntax:
```
name() {
  ...code...
}
```

## Sourcing
Functions are sourced exactly the same way Aliases are That said, defining them directly on the CLI is much more challenging and very rarely used. It is far more common to define the function in a file, then source that file. When testing/debugging the function it is usually easiest to write the function in a temporary file and source it with bash as such:
```
source my_tmp_function.bash
```

When executed the function in the 'my_tmp_function.bash' file would be read by bash and ready for use. If any syntax errors are detected the function will not be instantiated.

It is common to save your functions in one or more files, then source those files when Bash is started. You can define them directly in the .bashrc, just like Aliases, but again just like with aliases, it is more common to have them in an external file that is sourced by Bash at invocation. The command to source the file containing the function(s) is identical to the example above - it is simply added to the ~/.bashrc.



## Simple Bash Function Example
Here is an example that will wait a configuration amount of time, start flashing the terminal screen at you. As the name suggests, this is intended for use as a reminder when waiting for something else to complete. If called without an argument it will start flashing the terminal in 180 seconds. An argument that is less than 60 is considered to be in minutes and the $timer variable is the argument * 60. At that point the function runs the 'sleep' command for the amount of time specified by the $timer variable. Once the 'sleep' command ends the function runs a while loop that runs the 'echo' command followed by a 'sleep 1' command.
```
reminger() {
  if [ -z $1 ]; then
    timer=180
  else
    if [ $1 -lt 60 ]; then
      timer=$(($1*60))
    else
      timer=$1
    fi
  fi
  echo "Reminder will occur in $timer seconds"
  sleep $timer
  while [ 1 ]; do echo -e "\a"; sleep 1; done
}
```
If you are the distractible sort (like myself), it is quite easy to get distracted while waiting for something like a VM to boot, or for a Terraform Run to complete. Using this function can help draw your attention back to whatever long-running command you are waiting for rather than spending 20+ minutes watching a show when the command completed in much less time.

Functions can peform any task you can from the Bash CLI. As such they can become very complex (and quite long). For that reason the examples have been broken out into separate files.

## Examples
1. [synckey](https://github.com/jessed/guides/blob/main/Bash/examples/synckey.bash.md)
  * Copy the specified SSH public key to a remote system to enable SSH RSA authentication
  * This requires that the password be entered interactively to actually copy the public key, but after that SSH will use RSA authentication (assuming your SSH command specifies the key to be used or you are running ssh-agent with the proper private-key loaded).
2. [startagent](https://github.com/jessed/guides/blob/main/Bash/examples/startagent.bash.md)
  * Start an ssh-agent using ~/.ssh/ssh-agent as the communication socket
  * Pro-load the specified keys into the ssh-agent
