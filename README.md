# Drone-netlify

![Netlify logo](netlify.png?raw=true "netlify.com")

> Deploying to [Netlify](https://netlify.com) with [Drone](https://drone.io) CI.

Use case examples:

- Automatically deploy and alias upon pushes to master


There are two ways to deploy.

### From docker

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
