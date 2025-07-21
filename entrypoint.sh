#!/bin/sh -l

# remove dist directory if exists
if [ -d "dist/addon-checker" ]; then
  rm -r dist/addon-checker
fi

# create output directory
mkdir -p dist/addon-checker

# fix detected dubious ownership in repository at '/github/workspace'
git config --global --add safe.directory $PWD

# create the addon zip
git archive --output=./dist/addon-checker/addon.tar --format=tgz HEAD

# extract the addon zip to the destination where the kodi-addon-checker will run
if [ -z "$2" ]
then
    ADDON_DIR="./dist/addon-checker/addon"
    FOLDER_ID_MISMATCH="--allow-folder-id-mismatch"
else
    ADDON_DIR=./dist/addon-checker/$2
    FOLDER_ID_MISMATCH=""
fi
mkdir -p $ADDON_DIR
tar zxf ./dist/addon-checker/addon.tar -C $ADDON_DIR

if [ "$4" = true ] ; then
  python3 /modify_addonxml_matrix.py $ADDON_DIR
fi


if [ "$3" = true ] ; then
  kodi-addon-checker --branch=$1 $FOLDER_ID_MISMATCH --PR $ADDON_DIR
else
  kodi-addon-checker --branch=$1 $FOLDER_ID_MISMATCH $ADDON_DIR
fi

