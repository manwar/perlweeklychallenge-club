#!/usr/bin/env perl
use v5.24;
use List::Util 'max';
say max map { scalar(split m{\s+}mxs) } @ARGV;
