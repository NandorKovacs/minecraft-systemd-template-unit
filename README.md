A systemd template user unit capable of basic minecraft server management, launching the servers in a tmux session belonging to the user.

## The service assumes:
- that the minecraft server files are in .local/share/minecraft-servers
- that .local/share/minecraft-servers/<instance>/start.sh is an executable shell script, which terminates when the minecraft server jar does
- that the tmux socket "minecraft" is free

## How to install:
- place mc-wrapper.sh in /usr/local/libexec
- place minecraft@.service in /etc/systemd/user

## How to use:
Start, and stop the service with systemctl as you would with any other systemd user template unit.
Systemctl status will show the logs of the running server.

Furhtermore, you can attach to the interactive shell of an instance, using tmux -L minecraft attach -t <instance>

If this tmux session dies, the service will stop automatically.

## Fun facts:
Setting this up was a bit cursed; The wrapper script is needed, so that systemd watches the child process of the tmux session, and not the tmux daemon running on the minecraft socket. This has the small disadvantage that the pipe closes a slight bit before minecraft is actually finished shutting down; But we just keep this race condition in mind when using it.


