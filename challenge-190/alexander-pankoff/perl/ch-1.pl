#!/usr/bin/env perl
package challenge190::ch1;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce minstr);

use Test::More tests => 4;

is( capital_detection("Perl"),   1, "Example 1" );
is( capital_detection("TPF"),    1, "Example 2" );
is( capital_detection("PyThon"), 0, "Example 3" );
is( capital_detection("raku"),   1, "Example 4" );

sub capital_detection ($s) {
    return $s =~ s/[[:^alpha:]]//gr =~ m/^(?:
      [[:upper:]][[:lower:]]+ | # 1) Only first letter is capital and all others are small.
      [[:lower:]]+ |            # 2) Every letter is small.
      [[:upper:]]+ |            # 3) Every letter is capital.
      )$/x
      ? 1    #
      : 0;
}
