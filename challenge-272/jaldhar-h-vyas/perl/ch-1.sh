#!/bin/sh

perl -E '$_=shift;s/\./[.]/g;say' "$@"
