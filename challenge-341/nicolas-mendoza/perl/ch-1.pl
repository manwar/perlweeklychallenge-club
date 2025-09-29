#!/usr/bin/env perl

use Test2::V0;
use feature qw(signatures);

my $tests = {
  'Hello world'          => [ [ 'd'      ], 1 ],
  'apple banan cherry'   => [ [ 'a', 'e' ], 0 ],
  'Coding is fun'        => [ [          ], 3 ],
  'The Weekly Challenge' => [ [ 'a', 'b' ], 2 ],
  'Perl and Python'      => [ [ 'p'      ], 1 ],
};

for my $t (sort keys %{ $tests }) {
  is broken_keyboard($t, @{ $tests->{$t}->[0] }), $tests->{$t}->[1], "$t => $tests->{$t}->[1]";
}

done_testing;

sub broken_keyboard($in, @broken) {
  my @words = split m{\s+}, $in;
  my $pat   = "[@broken]";
  return @broken ? grep { $_ !~ m{$pat}i } @words : @words
}
