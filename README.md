# rpmsync
sync rpm packages

## push rpm packages
1. prepare gh
   ```bash
   make init
   ```
2. create rpmrepo releases
   ```bash
   make install-relall
   ```

## pull rpm packages
1. get && install rpmrepo 
   ```bash
   make install-repoall
   ```
