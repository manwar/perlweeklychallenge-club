#!/usr/bin/perl -s

use v5.16;
use warnings;
use List::Util 'max';
use Text::JaroWinkler 'strcmp95';

die <<EOS unless @ARGV == 2;
usage: $0 STR1 STR2

STR1 STR2
    two strings

EOS


say strcmp95(@ARGV, max map length, @ARGV);
