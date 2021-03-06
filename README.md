# action-kodi-addon-checker

![Kodi Logo](https://github.com/xbmc/xbmc/raw/master/docs/resources/banner_slim.png)

This action automatically runs [kodi-addon-checker](https://github.com/xbmc/addon-check) against your addon codebase. It checks the Kodi repo for best practices and produces a report containing found problems and warnings.
The action assumes you have your addon in the root path of your repository.

## Inputs

### `kodi-version`

**Required** The name of the minimal kodi version your addon is supposed to support (Default `"leia"`).
This is equivalent to the **branch** name where your addon lives in the official kodi repository ([repo-plugins](https://github.com/xbmc/repo-plugins/branches) or [repo-scripts](https://github.com/xbmc/repo-scripts/branches)).


### `addon-id`

**optional** The addon id of the addon being validated. This is used to extract the addon package using `git archive` and respect your `.gitattributes`. If not provided, the addon-check will allow folder id mismatching (by passing `--allow-folder-id-mismatch` to the tool).

### `is-pr`

**optional** If the action is being run as part of a pull request validation, normally used when the action is used as a step in automated submissions (Default `false`).

## `rewrite-for-matrix`

**optional** If the addon.xml should be re-written for kodi matrix - usefull if you are using the same branch to submit to two different branches (Default `false`).

## Example usage

To use this action in your github repository you need to have your addon code in the root directory of your github repository and name your repository accordingly (e.g. plugin.video.foo). The following example performs the addon validation on each git push or pull request taking into account you plan to submit your addon to the `leia` branch. The addon id is automatically extracted from your repository name.

```yaml
name: Kodi Addon-Check

on: [push, pull_request]

jobs:
  kodi-addon-checker:
    runs-on: ubuntu-latest
    name: Kodi addon checker
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Kodi addon checker validation
      id: kodi-addon-checker
      uses: xbmc/action-kodi-addon-checker@v1.1
      with:
        kodi-version: leia
        is-pr: false
        addon-id: ${{ github.event.repository.name }}

```
