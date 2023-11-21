# Drone-netlify

An updated fork from: https://github.com/lucaperret/drone-netlify

Deploying to [Netlify](https://netlify.com) with [Drone](https://drone.io) CI.

Use case examples:

- Automatically deploy and alias upon pushes to master

There are two ways to deploy.

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
docker build --platform linux/amd64 --no-cache=true -t rlachhman/netlify-drone-plugin:1760 .
docker push rlachhman/netlify-drone-plugin:1760    
```
