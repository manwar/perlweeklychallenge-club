#!/bin/sh

perl -E '@s=(reverse sort split //,shift);push @s,shift @s;say join q{},@s' "$@"
