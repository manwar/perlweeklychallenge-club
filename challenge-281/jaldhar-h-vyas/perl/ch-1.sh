#!/bin/sh

perl -E '$s;map{$s += ord}split//,shift; say $s%2!=1?"false":"true"' "$@"
