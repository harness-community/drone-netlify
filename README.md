# Drone-netlify

:clap: An updated fork from: [https://github.com/lucaperret/drone-netlify](https://github.com/lucaperret/drone-netlify). Thanks for creating!

:information_source: Current Repo Commands are based off of Netlify CLI Version [17.33.5](https://github.com/netlify/cli/releases/tag/v17.33.5)

Deploying to [Netlify](https://cli.netlify.com/commands/deploy/) with:
* [Drone](https://drone.io)
* [Gitness](https://gitness.com/)
* [Harness CI](https://www.harness.io/products/continuous-integration)

Use case examples:

- Automatically deploy and alias upon pushes to master

There are multiple ways to deploy to Netlify.

### From Docker

Deploy the working directory to Netlify.

```bash
docker run --rm \
  -e PLUGIN_TOKEN=xxxxx \
  -e PLUGIN_SITE_ID=xxxxxxx-xxxx-xxx-xxxxxxxx \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  rlachhman/netlify-drone-plugin
```

### From Drone CI

```yaml
pipeline:
  netlify:
    image: rlachhman/netlify-drone-plugin
    token: xxxxx
    site_id: xxxxxxx-xxxx-xxx-xxxxxxxx
```

### From Harness CI

```yaml
- step:
      identifier: <Harness-Identifier>
      type: Plugin
      name: <Step-Name>
      spec:
        connectorRef: <docker-hub-conector>
        image: rlachhman/netlify-drone-plugin
        privileged: true
        settings:
          dir: ./folder
          prod: true
          site_id: xxxxxxx-xxxx-xxx-xxxxxxxx
          token: xxxxx
          debug: "true"
          build: "false"
          context: deploy
```

### Building from Docker

```bash
docker build --platform linux/amd64 -t rlachhman/netlify-drone-plugin .
docker push rlachhman/netlify-drone-plugin    
```

#### Building from Docker for a Specific Version
For minor changes, sometimes Docker Builder will cache. For
example a small NPM Change on Netlify or small Shell Change. 

```bash
docker builder prune
docker build --platform linux/amd64 --no-cache=true -t rlachhman/netlify-drone-plugin:17334 .
docker push rlachhman/netlify-drone-plugin:17334    
```
