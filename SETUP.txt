My notes from: https://angular.schule/blog/2020-01-everything-github


Quick Angular 8 sandbox demo using Github pages:
---

install nvm, use it to install nodejs and npm
npm install -g @angular/cli
ng new my-sandbox --defaults
cd my-sandbox
git init
git add .
git commit -m "Initial commit of Angular sandbox"
manually: create repo in Github web UI
git remote add origin https://github.com/<username>/<reponame>
git push -u origin master
ng add angular-cli-ghpages
ng deploy --base-href=/<reponame>/
# note this creates and pushes git branch "gh-pages"
manually: verify settings OK for Github Pages https://github.com/<username>/<reponame>/settings
git add .
git commit -m "Build and deploy Angular sandbox to Github Pages"
git push origin master


Github Actions automation:
---
manually: create Personal Access Token with repo access https://github.com/<username>/<reponame>/settings
manually: add this new secret as GH_TOKEN to the Angular sandbox Github repo
manually: set up Github Action Workflow for the repo https://github.com/<username>/<reponame>/actions/new
copy/paste main.yml from tutorial, saves to <reponame>/.github/workflows/main.yml
TODO: get tests working

