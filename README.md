# gh-actions-example
This repository serves as an example on:
* How to configure a workflow which notifies Slack, builds and publishes a Docker image, and automatically versions the repo
* How to configure semantic versioning using [semantic-release](https://github.com/semantic-release/semantic-release), [commitlint](https://github.com/conventional-changelog/commitlint), and [husky](https://github.com/typicode/husky)

# How to Use This Repository
This repository can be used to experiment with the automated semantic versioning and get familiar with it. The repository MUST be returned back to a working state once done testing.

1. Install dependencies
    ```bash
    # If you use yarn
    yarn install

    # If you use npm
    npm install
    ```
1. Make a minor change and commit it to this repo with a message which follows the [Angular Commit Message Convention](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines). The commit message and TYPE can be whatever you'd like. Push to `master` when done.
1. [View the running action here.](https://github.com/blockstackpbc/gh-actions-example/actions)
1. Join the `#devops-notify` channel to observe the Slack notification(s).
1. Generated release notes can be found [here](https://github.com/blockstackpbc/gh-actions-example/blob/master/CHANGELOG.md) and [here](https://github.com/blockstackpbc/gh-actions-example/releases).

# Configure a Repo with Automatic Semantic Versioning
In order to configure a Git repo with automatic semantic versioning, follow the steps below:

1. Clone the project
1. Create a package.json file
    * Even if your project isn't a Node project, the package.json file serves as a config file for the [semantic-release](https://github.com/semantic-release/semantic-release), [commitlint](https://github.com/conventional-changelog/commitlint), and [husky](https://github.com/typicode/husky) Node modules.
1. Copy the commitlint, husky, and release configurations found in the example [package.json](https://github.com/blockstackpbc/gh-actions-example/blob/master/package.json#L7-L33) to the `package.json` in your project.
    * You can customize these configurations further using the Node modules' documentation
        * [semantic-release docs](https://github.com/semantic-release/semantic-release/blob/master/docs/usage/configuration.md#configuration)
        * [commitlint docs](https://commitlint.js.org/#/guides-local-setup)
        * [husky docs](https://github.com/typicode/husky/blob/master/README.md)
1. Run the following to install the commitlint and husky packages locally and save them as development dependencies to the `package.json`
    * Only commitlint and husky need to be installed locally, semantic-release does not since it'll only be used by Github Actions.
    * Upon installation of `husky`, it will attempt to create a pre-commit hook in your git repo
    * If you see errors, resolve them then try re-installing.
    ```bash
    # If you use yarn
    yarn add --dev husky @commitlint/{config-conventional,cli} --force

    # If you use npm
    npm install --save-dev husky @commitlint/{config-conventional,cli}
    ```
1. Activate hooks
    ```bash
    # If you use yarn
    yarn husky install

    # If you use npm
    npx husky install
    ```
1. Add hook
    ```bash
    npx husky add .husky/commit-msg 'npx --no-install commitlint --edit'
    ```
1. Add the following files/dirs to the .gitignore file (unless you want to commit any of them):
    ```bash
    echo -e "node_modules\npackage-lock.json\nyarnlock" >> .gitignore
    ```
1. Add a Github Actions workflow to `.github/workflows/`
    * [Example workflow using semantic-release](https://github.com/blockstackpbc/gh-actions-example/blob/master/.github/workflows/main.yml)
    * [See the Github Actions documentation for more info](https://docs.github.com/en/actions)
1. Commit all new files/modifications (except for anything being ignored)
    * Upon commit, you should see a pre-commit hook fire which runs commitlint and checks your commit message. Your message must conform to the [Angular Commit Message Convention](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines), otherwise it will be denied by commitlint. If this does not happen or an error occurs, try resolving the error then try again.

Going forward, anyone who wishes to commit to your repository will need to run the following command beforehand to install local dev dependencies. It should be quick and only take a few seconds:
```bash
    # If you use yarn
    yarn install

    # If you use npm
    npm install
```
