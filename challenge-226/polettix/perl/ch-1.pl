#!/usr/bin/env perl
use v5.24;
say join '', (split //, $ARGV[0])[@ARGV[1 .. $#ARGV]];
