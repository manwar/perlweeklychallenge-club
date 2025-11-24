#!raku

#
# Perl Weekly Challenge 349
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
#

sub MAIN( Str $directions ) {
    my %moves;
    %moves{ $_ }++ for ( $directions.comb );

    'True'.say and exit if ( %moves<U> == %moves<D> && %moves<R> == %moves<L> );
    'False'.say;
}
