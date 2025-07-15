#!/bin/sh

perl -E '$_=shift;while(s/([a-z])(??{uc $1})|([A-Z])(??{lc $2})//){}say' "$@"
