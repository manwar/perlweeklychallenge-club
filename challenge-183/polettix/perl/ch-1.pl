#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use JSON::PP;

my @list = ([1,2], [3,4], [5,6], [1,2]);
say JSON::PP::encode_json($_) for remove_duplicate_subarrays(@list);

sub remove_duplicate_subarrays (@l) {
   state $encoder = JSON::PP->new->ascii->canonical;
   my %seen;
   grep {!$seen{$encoder->encode($_)}++} @l;
}
