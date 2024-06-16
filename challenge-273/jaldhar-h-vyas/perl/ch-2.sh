#!/bin/sh

perl -E '$_=shift;say /(b)\1[^a]*/?"true":"false"' "$@"
