# action-kodi-addon-checker

![Kodi Logo](https://github.com/xbmc/xbmc/raw/master/docs/resources/banner_slim.png)

This action automatically runs [kodi-addon-checker](https://github.com/xbmc/addon-check) against your addon codebase. It checks the Kodi repo for best practices and produces a report containing found problems and warnings.
The action assumes you have your addon in the root path of your repository.

## Inputs

### `kodi-version`

**Required** The name of the minimal kodi version your addon is supposed to support (Default `"leia"`).

This is equivalent to the **branch** name where your addon lives in the official kodi repository ([repo-plugins](https://github.com/xbmc/repo-plugins/branches) or [repo-scripts](https://github.com/xbmc/repo-scripts/branches)).

## Example usage

To use this action in your github repository you need to have your addon code in the root directory of your github repository. The following example performs the addon validation on each git push taking into account you plan to submit your addon to the `leia` branch (thus taking into account the leia repository rules).

```yaml
name: Kodi Addon-Check

on: [push]

jobs:
  kodi-addon-checker:
    runs-on: ubuntu-latest
    name: Kodi addon checker
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Kodi addon checker validation
      id: kodi-addon-checker
      uses: xbmc/action-kodi-addon-checker@v1.0
      with:
        kodi-version: leia

```
