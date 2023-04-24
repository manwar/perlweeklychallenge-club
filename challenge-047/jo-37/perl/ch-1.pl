#!/usr/bin/perl

use v5.16;
use warnings;
use Roman;

say Roman(eval qq{arabic("$ARGV[0]") $ARGV[1] arabic("$ARGV[2]")});
