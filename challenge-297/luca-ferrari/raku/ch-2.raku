#!raku

#
# Perl Weekly Challenge 297
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
#

sub MAIN( *@ints is copy where { @ints.grep( *.Int ).elems == @ints.elems } ) {
    my $swaps = 0;
    my $index =  @ints.grep( * == 1, :k ).first;
    $swaps += $index;

    @ints = | 1, | @ints[ 0 ..^ $index ], | @ints[ $index ^.. * - 1 ];

    $index =  @ints.grep( * == @ints.elems, :k ).first;
    $swaps += @ints.elems - $index - 1;

    @ints = | @ints[ 0 ..^ $index ], | @ints[ $index ^.. * - 1 ], @ints.elems;

    $swaps.say;

}
