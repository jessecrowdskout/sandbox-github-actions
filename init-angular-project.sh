#!/usr/bin/env bash
# shellcheck disable=SC2086
# Quick Angular 8 sandbox demo using Github pages:


usage(){
	echo
	echo "USAGE:"
	echo "init-angular-project.sh <your-project-name> <your-github-username>"
	echo
}

if [[ -n $1 ]]; then echo "Project Name: $1"; else usage && exit; fi
PROJECTNAME=$1

if [[ -n $2 ]]; then echo "Github Username: $2"; else usage && exit; fi
GITHUBUSERNAME=$2


# for most control, install nvm, use it to install nodejs and npm
# or more simply use brew to install nodejs and npm
echo "Node.js version: $(node --version)"
echo "NPM version: $(npm --version)"
#npm install -g @angular/cli
ng --version


ng new ${PROJECTNAME} --defaults
cd ${PROJECTNAME} || exit
git init
git add .
git commit -m "Initial commit of Angular sandbox, if any issues can rollback to this commit to try again"
cd - || exit


echo
echo "Github Repository creation:"
echo "--------------------------"
#TODO: use Github API for these steps rather than manually performing them
echo "manually: create public repo named ${PROJECTNAME} in Github web UI https://github.com/new"
echo
read -n 1 -s -r -p "Press any key to continue..."
echo



echo
echo "Github Actions automation:"
echo "--------------------------"
#TODO: use Github API for these steps rather than manually performing them
echo "manually: create Personal Access Token with repo access https://github.com/settings/tokens"
echo "manually: add this new secret as GH_TOKEN to the Angular sandbox Github repo https://github.com/${GITHUBUSERNAME}/${PROJECTNAME}/settings/secrets"
echo
read -n 1 -s -r -p "Press any key to continue..."
echo


echo "Creating Github Actions workflow configuration: ${PROJECTNAME}/.github/workflows/main.yml"
mkdir -p ${PROJECTNAME}/.github/workflows && ls -ld ${PROJECTNAME}/.github/workflows
cp github-actions-main.yml ${PROJECTNAME}/.github/workflows/main.yml
ls -l ${PROJECTNAME}/.github/workflows
sed -e "s/PROJECTNAME/${PROJECTNAME}/g" -i '' ${PROJECTNAME}/.github/workflows/main.yml
echo
echo "cat ${PROJECTNAME}/.github/workflows/main.yml"
echo "---------------------------------------------"
echo
cat ${PROJECTNAME}/.github/workflows/main.yml
echo


echo "Next step will fail if Github repo doesn't exist and/or SSH key not configured:"
echo
cd ${PROJECTNAME} || exit
git remote add origin git@github.com:${GITHUBUSERNAME}/${PROJECTNAME}
git push -u origin master


ng add angular-cli-ghpages
# note this creates and pushes git branch "gh-pages"


ng deploy --base-href=/${PROJECTNAME}/
echo "manually: verify settings OK for Github Pages https://github.com/${GITHUBUSERNAME}/${PROJECTNAME}/settings"


git add .
git commit -m "Build and deploy Angular sandbox to Github Pages"
git push origin master
cd - || exit

echo
echo "Check out the results:"
echo "--------------------------"
echo "Check out your Github Actions Workflows, should be running: https://github.com/${GITHUBUSERNAME}/${PROJECTNAME}/actions"
echo "Check out your Github Deployments, should be running: https://github.com/${GITHUBUSERNAME}/${PROJECTNAME}/deployments"
echo "Check out your Github Pages, will be available when Workflow and Deployment steps completed: https://${GITHUBUSERNAME}.github.io/${PROJECTNAME}/"
echo
echo "Done."
