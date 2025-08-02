#!raku

#
# Perl Weekly Challenge 267
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    '0'.say and exit if ( @nums.grep( * == 0 ) );
    '-1'.say and exit if ( @nums.grep( * < 0 ).elems !%% 2 );
    '1'.say;
}
