# Setup Enviroment

``` bash
# Run Init Script
bash init.sh

# Update Config Files
vim config.json

# Configure Forever
forever start -c coffee config.json
```

# Stop Service on Forever
```
forever stop start.coffee
```

# Log Watching
```
tail -f logs/log*
```

# Kill Forever Deamon
```
forever stopall
```
