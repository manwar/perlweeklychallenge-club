#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 330 Task 2: Title Capital
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub title_capital( $str ) {
    return $str =~ s<(\w)(\w?)(\w*)>{
        ( $3 ? uc $1 : lc $1 ) . lc "$2$3"
    }egr;
}

use Test2::V0 qw( -no_srand );

is title_capital( "PERL IS gREAT" ), "Perl is Great",
    'Example 1: title_capital( "PERL IS gREAT" ) == "Perl is Great"';
is title_capital( "THE weekly challenge" ), "The Weekly Challenge",
    'Example 2: title_capital( "THE weekly challenge" ) == "The Weekly Challenge"';
is title_capital( "YoU ARE A stAR" ), "You Are a Star",
    'Example 3: title_capital( "YoU ARE A stAR" ) == "You Are a Star"';

done_testing;
