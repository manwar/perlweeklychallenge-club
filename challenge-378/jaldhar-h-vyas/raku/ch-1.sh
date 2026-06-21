#!/bin/sh

raku -e 'say (@*ARGS[0].match(/(\d)/,:g)».Int.sort({$^b <=>$^a}).unique)[1]//-1' "$@"
