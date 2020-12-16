# It's all fun in games

### For development
We're using 'json-server' and the json file located in the /shared folder
```bash 
npm install -g json-server && \
    json-server --port 3001 --watch ./shared/db.json
```

Also, the app needs a host file change of 
```bash 
sudo sh -c 'echo "\n127.0.0.1       fakeagram.local" >> /etc/hosts'
```