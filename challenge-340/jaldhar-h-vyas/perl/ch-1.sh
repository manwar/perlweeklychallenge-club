#!/bin/sh

perl -E '$_=shift;while(s/(.)\1//){}say' "$@"
