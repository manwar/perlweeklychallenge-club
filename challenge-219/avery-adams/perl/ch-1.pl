#!/usr/bin/perl
use strict;
use v5.24;

say $_ for (sort {$a <=> $b} (map {$_ * $_} @ARGV));
