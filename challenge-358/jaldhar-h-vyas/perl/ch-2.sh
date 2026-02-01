#!/bin/sh

perl -E 'say join q{},map{chr(ord("a")+(ord($_)-ord("a")+$ARGV[1])%26)}split //,$ARGV[0]' "$@"
