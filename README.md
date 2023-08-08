# Sleep-Bash-Script-for-ubuntu
A bash Script that enable the Sleep mode(mise enVeille )for lunix machine.

a script that puts the Ubuntu server to sleep when it is not working requires monitoring the server's activity or load and then determining if it is inactive for a specific period before putting it to sleep. To monitor the server's activity, we can check its CPU usage. If the CPU usage is below a certain threshold for a defined period, we can trigger the sleep action.

First i create the file Idle_server.sh
nano idle_server.sh

After that i make it executable:
chmod +x idle_server.sh

To run the script in the background every time i launch the machine, i use a startup script that runs the monitoring script as a background process during boot.
nano idle_server_starter.sh
then i made it executable:
chmod +x idle_server_starter.sh

Then i Created a Systemd service file.  named idle_server_starter.service in the /etc/systemd/system/ directory:
nano idle_server_starter.service

i saved the file and then  reload Systemd to detect the new service:
sudo systemctl daemon-reload
i enable the service to run at boot:
sudo systemctl enable idle_server_starter.service


