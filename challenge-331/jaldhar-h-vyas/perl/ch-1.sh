#!/bin/sh

perl -E '$_=shift;/(\w+)\W*$/;say length$1||0' "$@"
