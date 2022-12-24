#!/bin/sh
set -e

#CLI Commands: https://cli.netlify.com/commands/deploy

NETLIFY_SITE=""
NETLIFY_DEPLOY_OPTIONS=""


#Prod Flag
if [ -n "$PLUGIN_PROD" ]
then
    NETLIFY_DEPLOY_OPTIONS="--prod ${PLUGIN_PROD}"
fi

#Debug Flag
if [ -n "$PLUGIN_DEBUG" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --debug ${PLUGIN_DEBUG}"
fi

#Netlify CI Build Flag
if [ -n "$PLUGIN_BUILD" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --build ${PLUGIN_BUILD}"
fi

#Message Flag
if [ -n "$PLUGIN_MESSAGE" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --message ${PLUGIN_MESSAGE}"
fi

#Upload Location Dir Flag
if [ -n "$PLUGIN_DIR" ]
then
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ${PLUGIN_DIR}"
else
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ./"
fi

#Netlify Token
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

#Output Info
echo "> Netlify CLI and NodeJS Version: " && netlify -v 

#Deploy Step
if [ -n "$PLUGIN_SITE_ID" ] && [ -n "$PLUGIN_TOKEN" ]
then
    NETLIFY_SITE="--auth $PLUGIN_TOKEN --site $PLUGIN_SITE_ID"
    echo "> Executing: netlify deploy $NETLIFY_SITE $NETLIFY_DEPLOY_OPTIONS"
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
    echo $'\n'"> Successfully Deployed!"$'\n'
fi
