#!/bin/sh

perl -E '$i=1;say join q{},map{$_ x$i++}split//,shift' "$@"
