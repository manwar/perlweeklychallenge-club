#!raku

#
# Perl Weekly Challenge 250
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    $_.say and exit if ( @nums[ $_ ] == ( $_ % 10 ) ) for 0 ..^ @nums.elems;
    '-1'.say;
}
