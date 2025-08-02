#!raku

#
# Perl Weekly Challenge 320
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-320>
#

sub MAIN( *@numbers where { @numbers.grep( *.Int > 0 ).elems == @numbers.elems } ) {
    my $sum = @numbers.sum;
    my $digit-sum = @numbers.map( *.comb ).sum;
    say abs( $digit-sum - $sum );
}
