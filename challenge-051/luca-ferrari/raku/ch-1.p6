#!env raku


# Perl Weekly Challenge 50
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-051/>
#
# Task 1
# Given an array @Lof integers. Write a script
# to find all unique triplets
# such that a + b + c is same as the given target T.
# Also make sure a <= b <= c.
#
#
#
# Example of execution:
# % raku ch-1.p6
# Found 2 triplets that sum to 0:
#  -10 2 8
#  -7 -3 10




sub MAIN( Int:D $target? = 0,
          @*L? where { @*L.grep(  * ~~ Int  ).elems > 3 }  = ( -25, -10, -7, -3, 2, 4, 8, 10 )  ) {

    # store the found triplets
    my @triplets;

    # extract only the integers
    my @L = @*L.sort.grep( * ~~ Int );

    # loop over the array
    loop ( my $first-start = 0; $first-start < @L.elems - 2; $first-start++ ) {
        my $first = @L[ $first-start ];
        loop ( my $second-start = $first-start + 1; $second-start < @L.elems - 1; $second-start++ ) {
            my $second = @L[ $second-start ];

            next if $second < $first;

            loop ( my $third-start = $second-start + 1; $third-start < @L.elems; $third-start++ ) {
                my $third = @L[ $third-start ];

                next if $third < $second;

                @triplets.push: Array.new( $first, $second, $third ) if ( $first + $second + $third == $target; );
            }
        }


    }

    "Found { @triplets.elems } triplets that sum to $target:".say;
    @triplets.join( "\n" ).say;

}
