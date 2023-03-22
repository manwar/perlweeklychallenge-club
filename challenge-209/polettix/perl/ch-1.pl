#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my @bits = map { split m{}mxs } @ARGV;
say special_bits_characters(\@bits);

sub special_bits_characters ($bits) {
   join('', $bits->@*) =~ m{\A (?: 1[01] | 0 )* 0 \z}mxs ? 1 : 0;
}
