#!raku

#
# Perl Weekly Challenge 332
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
#

sub MAIN( Str $string ) {
    my $bag = Bag.new: $string.comb;
    'false'.say and exit if ( $bag.values.grep( * > 1 ) );
    'true'.say;
}
