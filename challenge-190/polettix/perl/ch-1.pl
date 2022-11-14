#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say capital_detection(shift // 'whatever');

sub capital_detection ($string) {
   0 + $string =~ m{\A(?:[a-z]*|[a-zA-Z][a-z]*|[A-Z]*)\z}mxs;
}
