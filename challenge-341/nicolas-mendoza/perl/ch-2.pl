#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0;
use feature qw(signatures);

my $tests = {
  'programming' => [ 'g', 'gorpramming' ],
  'hello'       => [ 'h', 'hello'       ],
  'abcdefghij'  => [ 'h', 'hgfedcbaij'  ],
  'reverse'     => [ 's', 'srevere'     ],
  'perl'        => [ 'r', 'repl'        ],
};

for my $t (sort keys %{ $tests }) {
  is reverse_prefix($t, $tests->{$t}->[0]), $tests->{$t}->[1], "$t => $tests->{$t}->[1]";
}

done_testing;

sub reverse_prefix($str, $char) {
  $str =~ s{(.*?$char)}{reverse $1}e;
  return $str;
}
