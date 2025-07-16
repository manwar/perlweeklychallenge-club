#!/bin/sh

perl -E '$_=shift;while(s/\D\d//){}say' "$@"
