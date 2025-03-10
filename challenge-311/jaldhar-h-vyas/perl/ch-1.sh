#!/bin/sh

perl -E '$_=shift;s/(.)/uc$1eq$1?lc$1:uc$1/ge;say' "$@"
