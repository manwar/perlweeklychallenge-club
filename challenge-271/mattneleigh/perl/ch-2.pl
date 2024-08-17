#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ],
    [ 1024, 512, 256, 128, 64 ],

    # Additional test case(s)
    [ 18446744073709551615, 7, 20, 128, 18446744073709551614 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", sort_ints_by_one_bit_count(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort a list of positive integers in ascending order by the number of ones in
# their binary representation; numbers having the same quantity of ones will be
# ordered by their numerical value
# Takes one argument:
# * A list of positive integers to examine (e.g. ( 0, 1, 2, 3, 4, 5, 6, 7, 8 )
#   )
# Returns:
# * The list of integers sorted by the count of ones in their binary
#   representation (e.g. ( 0, 1, 2, 4, 8, 3, 5, 6, 7 ) )
################################################################################
sub sort_ints_by_one_bit_count{

    my $int;
    my $one_count;

    return(
        # 3. Build a list of numerical values
        # extracted from the sorted list of pairs
        map(
            $_->[0],

            # 2. Sort the list in ascending order by the
            # count of ones unless the number of ones is
            # equal, in which case sort by numerical
            # value
            sort(
                {
                    $a->[1] == $b->[1] ?
                        $a->[0] <=> $b->[0]
                        :
                        $a->[1] <=> $b->[1]
                }
                # 1. Build a list of numerical values paired
                # with the counts of ones in each
                map(
                    {
                        $int = $_;
                        $one_count = 0;

                        while($int){
                            $one_count++
                                if($int & 0x01);
                            $int >>= 1;
                        }

                        [ $_, $one_count ];

                    }
                    @ARG
                )
            )
        )
    );

}



