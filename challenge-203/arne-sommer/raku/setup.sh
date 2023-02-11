#! /usr/bin/env sh

rm -R /tmp/x
rm -R /tmp/a

mkdir /tmp/x
mkdir /tmp/x/y

mkdir /tmp/a /tmp/a/b /tmp/a/b/c
mkdir /tmp/a/b/c/1 /tmp/a/b/c/2 /tmp/a/b/c/3 /tmp/a/b/c/4 /tmp/a/b/c/5

touch /tmp/a/b/c/1/1.txt
touch /tmp/a/b/c/2/2.txt
touch /tmp/a/b/c/3/3.txt
touch /tmp/a/b/c/5/5.txt
