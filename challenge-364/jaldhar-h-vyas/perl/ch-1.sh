#!/bin/sh

perl -E 'say join q{},map{chr(0x60+$_)}grep{$_}shift=~/(\d\d)\#|(\d)/g' "$@"


