#!/bin/sh

perl -E 'say scalar grep{(length $_)%2==0}@ARGV' "$@"