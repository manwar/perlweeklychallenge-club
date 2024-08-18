#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 282 Task 1: Good Integer
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub good_integer( $int ) {
    return $int =~ / (?: ^ | (\d)(?!\g{-1}) ) ( (\d)\g{-1}\g{-1} ) (?!\g{-1}) /x ? $2 : -1;
}

use Test2::V0 qw( -no_srand );

my $sub_name = "good_integer";
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "Testing $sub:";
    no strict 'refs';
    is $sub->( 12344456 ), 444,
        'Example 1: good_integer( 12344456 ) == 444';
    is $sub->( 1233334 ), -1,
        'Example 2: good_integer( 1233334 ) == -1';
    is $sub->( 10020003 ), "000",
        'Example 3: good_integer( 10020003 ) == "000"';
}
done_testing;
