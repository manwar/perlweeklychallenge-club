#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use JSON::PP;
use List::Util 'reduce';

say encode_json(common_characters(@ARGV)) =~ tr{[]}{()}r;

sub common_characters (@words) {
   return [] unless @words;
   my $aref = reduce {
         my %s = map { $_ => 1 } $b->@*;
         [ grep { $s{$_} } $a->@* ];
      }
      map { [ split m{}mxs ] }
      @words;
   return [ sort { $a cmp $b } $aref->@* ];
}
