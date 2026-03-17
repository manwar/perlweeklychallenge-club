#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 364 Task 2: Goal Parser
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub goal_parser( $str ) {
    return $str =~ s/ \(\) /o/xgr =~ s/ \(al\) /al/xgr;
}

use Test2::V0 qw( -no_srand );

is goal_parser( "G()(al)" ), "Goal",
    'Example 1: goal_parser( "G()(al)" ) eq "Goal"';
is goal_parser( "G()()()()(al)" ), "Gooooal",
    'Example 2: goal_parser( "G()()()()(al)" ) eq "Gooooal"';
is goal_parser( "(al)G(al)()()" ), "alGaloo",
    'Example 3: goal_parser( "(al)G(al)()()" ) eq "alGaloo"';
is goal_parser( "()G()G" ), "oGoG",
    'Example 4: goal_parser( "()G()G" ) eq "oGoG"';
is goal_parser( "(al)(al)G()()" ), "alalGoo",
    'Example 5: goal_parser( "(al)(al)G()()" ) eq "alalGoo"';

done_testing;
