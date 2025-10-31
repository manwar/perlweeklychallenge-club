#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 5, -1, -1 ],
    [ 3, 7, -1, -1, -1 ],
    [ 2, -1, 4, -1, -1 ],
    [ 10, 20, -1, 30, -1, -1 ],
    [ -1, -1, 5, -1 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", process_ints(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, in which every element is either positive or -1,
# step through the array, applying the following rules:
# 1) If the current integer is positive, place it at the front of an array
#    @seen
# 2) If the current integer is -1:
#     2a) If the length of @seen is greater than the number of consecutive
#         -1s seen before this one ($neg_count), append $seen[$neg_count] to an
#         array @ans
#     2b) Or append -1 to @ans
# After all input integers have been processed, the array @ans will be returned
# Takes one argument:
# * The array of integers to process (e.g. (3, 7, -1, -1, -1) )
# Returns:
# * The array @ans, constructed as described above (e.g. (7, 3, -1) )
################################################################################
sub process_ints{

    my @seen;
    my @ans;
    my $neg_count = 0;

    # Loop over each int
    foreach my $int (@ARG){
        if($int == -1){
            # This is -1:
            # Store the appropriate value at the end of
            # @seen, as prescribed by the rules stated
            # above
            push(
                @ans,
                $neg_count < scalar(@seen) ?
                    $seen[$neg_count]
                    :
                    -1
            );

            # Increment the negative count
            $neg_count++;
        } else{
            # This is not -1:
            # Store this int at the front of @seen
            unshift(@seen, $int);

            # Reset the negative count
            $neg_count = 0;
        }
    }

    return(@ans);

}



