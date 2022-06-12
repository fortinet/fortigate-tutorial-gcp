#### FortiGate Deployment Tutorial for Google Cloud
# Verifying deployment

Congratulations! It seems you have successfully deployed a FortiGate tutorial. You probably want to make sure it works now. Here are the steps to help you make sure everything deployed correctly:

1. give it a minute - although your deployment finished, the FortiGates (and the servers) need to go through the initial bootstrapping process including verifying the licenses and installing additional software. It might take a few minutes before everything is completed.
1. use your web browser to connect to the service IP. Use HTTP protocol, not HTTPS - adding SSL to the frontend server is not complicated but not part of this tutorial. You should see a default "It works!" nginx page. If you get a "502 gateway error" or the connection times out, give it some more time.
1. add "/eicar.com" to the end of your URL. Eicar is a small harmless file used for testing anti-virus protection and is uploaded to the root directory of your test web server. You should see a FortiGate block page indicating it stopped the attempt to download a malware
1. use the default password (set to primary FortiGate instance ID) to log into the web management console of the primary FortiGate. You will be asked to change your password and re-login using it.
1. go to the Logs > Forwarding Log and use filtering to locate the following:
    - workload servers attempts to go out to the Internet - there should be several connections to **Ubuntu.Updates** application from sources in `10.*.*.*` subnets
    - your connection to the web server - look for connections from public IP address (yours) to another public IP address on port 80. You might find more than one as anyone can connect to your sample web application
    - blocked "infected" connection from proxy to web server
