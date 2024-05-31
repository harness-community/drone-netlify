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

#Context Flag
if [ -n "$PLUGIN_CONTEXT" ]
then
    NETLIFY_DEPLOY_OPTIONS="--context ${PLUGIN_CONTEXT}"
fi

#Prod if Locked Flag
if [ -n "$PLUGIN_PRODLOCKED" ]
then
    NETLIFY_DEPLOY_OPTIONS="--prod-if-unlocked ${PLUGIN_PRODLOCKED}"
fi

#Debug Flag
if [ -n "$PLUGIN_DEBUG" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --debug ${PLUGIN_DEBUG}"
fi

#Timeout Flag
if [ -n "$PLUGIN_TIMEOUT" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --timeout ${PLUGIN_TIMEOUT}"
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

#Timeout Flag
if [ -n "$PLUGIN_TIMEOUT" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --message ${PLUGIN_TIMEOUT}"
fi

#JSON Flag
if [ -n "$PLUGIN_JSON" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --message ${PLUGIN_JSON}"
fi

#Upload Location Dir Flag
if [ -n "$PLUGIN_DIR" ]
then
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ${PLUGIN_DIR}"
else
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --dir ./"
fi

#Functions Location Dir Flag
if [ -n "$PLUGIN_FUNCTIONS" ]
then
    NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --functions ${PLUGIN_FUNCTIONS}"
fi

#Skip Functions Cache Flag
if [ -n "$PLUGIN_SKIPFUNCTIONSCACHE" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --skip-functions-cache ${PLUGIN_SKIPFUNCTIONSCACHE}"
fi

#Filter for MONOREPO Flag
if [ -n "$PLUGIN_FILTER" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --filter ${PLUGIN_FILTER}"
fi

#Alias Flag
if [ -n "$PLUGIN_ALIAS" ]
then
     NETLIFY_DEPLOY_OPTIONS="${NETLIFY_DEPLOY_OPTIONS} --alias ${PLUGIN_ALIAS}"
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
    netlify deploy $NETLIFY_SITE $NETLIFY_DEPLOY_OPTIONS | tee out.txt
    draft_url=$(cat out.txt | grep -o 'Website draft URL: .*' | awk '{print $4}')
    echo "DRAFT_URL=$draft_url" >> $DRONE_OUTPUT    
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
