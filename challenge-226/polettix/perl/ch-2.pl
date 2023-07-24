#!/usr/bin/env perl
use v5.24;
use List::Util 'uniq';
say scalar grep { $_ } uniq @ARGV;
