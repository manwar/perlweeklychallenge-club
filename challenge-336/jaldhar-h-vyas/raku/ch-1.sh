#!/bin/sh

raku -e '@*ARGS.classify({$_},:into(my %c));say ([gcd] %c.values)>=2' "$@"