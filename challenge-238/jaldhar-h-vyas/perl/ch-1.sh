#!/bin/sh

perl -E 'say q{(},(join q{, },map{$t+=$_}@ARGV),q{)}' "$@"