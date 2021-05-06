#!/usr/bin/env perl
use utf8;                     # so literals and identifiers can be in UTF-8
use v5.24;
use strict;                   # quote strings, declare variables
use warnings;                 # on by default
use warnings qw(FATAL utf8);  # fatalize encoding glitches
use open qw(:std :utf8);      # undeclared streams in UTF-8
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

use Unicode::Normalize;
use Unicode::Collate;
use Encode qw(decode_utf8);

@ARGV = map { decode_utf8($_, 1) } @ARGV;

my @pairs;
while (<>) {
   my $pair = check_ordered(NFD($_)) // next;
   push @pairs, $pair;
}
say for reverse map { $_->[1] } sort { $a->[0] <=> $b->[0] } @pairs;

sub check_ordered ($x) {
   state $coll = Unicode::Collate->new(level => 1);
   state $es = Unicode::Collate->new(level => 1, normalization => undef);
   my @chars = $x =~ m{(\X)}gmxs;
   shift @chars while @chars && $chars[0] =~ m{[\h\v]}mxs;
   pop @chars   while @chars && $chars[-1] =~ m{[\h\v]}mxs;
   my $original   = join '', @chars;
   my $rearranged = join '', $coll->sort(@chars);
   return [scalar(@chars), $original] if $es->eq($original, $rearranged);
   return;
} ## end sub check_ordered ($x)
