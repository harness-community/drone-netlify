#!/bin/sh
set -e

#CLI Commands: https://cli.netlify.com/commands/deploy

NETLIFY_SITE=""
NETLIFY_DEPLOY_OPTIONS=""


if [ -n "$PLUGIN_PROD" ]
then
    NETLIFY_DEPLOY_OPTIONS="--prod ${PLUGIN_PROD}"
fi

if [ -n "$PLUGIN_PATH" ]
then
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ${PLUGIN_PATH}"
else
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ./"
fi

if [ -z "$PLUGIN_TOKEN" ]
then
    if [ -z "$NETLIFY_TOKEN" ]
    then
        echo "> Error! token or netlify_token secret is required"
        exit 1;
    else
        PLUGIN_TOKEN="$NETLIFY_TOKEN"
    fi
fi

if [ -n "$PLUGIN_SITE_ID" ] && [ -n "$PLUGIN_TOKEN" ]
then
    NETLIFY_SITE="--auth $PLUGIN_TOKEN --site $PLUGIN_SITE_ID"
    echo "> Deploying on Netlify…" &&
    netlify deploy $NETLIFY_SITE $NETLIFY_DEPLOY_OPTIONS;
else
    echo "> Error! site_id and token are required"
    exit 1
fi


rc=$?;
if [[ $rc != 0 ]];
then 
    echo "> non-zero exit code $rc" &&
    exit $rc
else
    echo $'\n'"> Successfully deployed!"$'\n'
fi
