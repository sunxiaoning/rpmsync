# rpmsync
sync rpm packages

## push rpm packages
1. prepare gh
   `make init`
2. create rpmrepo releases
   `make install-relall`

## pull rpm packages
1. get && install rpmrepo 
   `make install-repoall`
