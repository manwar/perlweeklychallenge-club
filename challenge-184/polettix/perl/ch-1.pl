#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @list = qw< ab1234 cd5678 ef1342 >;
sequence_number(\@list);
say for @list;

sub sequence_number ($list) {
   my $n = 0;
   substr $_, 0, 2, sprintf '%02d', $n++ for $list->@*;
   return $list;
}
