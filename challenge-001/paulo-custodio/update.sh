#!/bin/sh -ex

git checkout master
git pull
git fetch upstream
git merge upstream/master --ff-only
git push -u origin master

git checkout devel
git pull
git merge master
git push -u origin devel
