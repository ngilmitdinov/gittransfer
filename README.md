#What is it

This script for transfering groups of repos from one gitlab to another gitlab.


#How to use

You need to have ssh keys for both version control systems.

In source in VCS, you need to have personal access token. You can get it in the admin panel. Specify it in the PRIVATE_TOKEN variable.

In the SRC_GIT and DEST_GIT variables, specify the addresses of your VCS.

In the REPO_GROUP variable, specify the repository group to migrate.
