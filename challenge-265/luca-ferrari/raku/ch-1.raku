#!raku

#
# Perl Weekly Challenge 265
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my %pct;
    %pct{ $_ } += 1 / @nums.elems for @nums;

    my @good_ones = %pct.kv.grep( -> $k, $v { $v >= 33 / 100 ?? True !! False } );
    exit if ! @good_ones;

    @good_ones.map( { $_[ 0 ] } ).sort.head.say;

}
