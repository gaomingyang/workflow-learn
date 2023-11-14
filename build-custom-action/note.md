build 
```
docker build --tag keyword-release .
```

```
./entrypoint.sh
./entrypoint.sh "FIXED an error"
```

Use Runtime Environment Resources
Environment Variables

three useful
GITHUB_TOKEN
GITHUB_REPOSITORY
GITHUB_EVENT_PATH

events and payloads
events:
push
create and delete branches 
pull request

each event has a different payload
https://docs.github.com/en/rest/overview/github-event-types?apiVersion=2022-11-28
