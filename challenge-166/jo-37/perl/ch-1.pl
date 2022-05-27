#!/usr/bin/perl

use v5.16;
use warnings;

$ARGV[0] ||= '../../../data/dictionary.txt';

while (<>) {
    chomp;
    tr/olist/01157/;
    next unless /^[0-9a-f]{2,8}$/;
    # Allow a maximum of two lesser comprehensible letters.
    # Force global match into list context, then convert to scalar.
    # See "Goatse" in perlsecret.
    next if 2 < (() = /[157]/g);
    say "0x\u$_";
}
