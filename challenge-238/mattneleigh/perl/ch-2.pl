#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 15, 99,  1, 34 ],
    [ 50, 25, 33, 22 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", digit_product_steps_sort(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort a list of integers in ascending order according to the number of
# iterations required to reduce each to a single digit by calculating the
# product of each digit within the number, then repeating the process through
# successive products until only one digit remains; if two or more numbers
# require the same number of steps, they will be arranged in ascending order
# according to their original values
# Takes one argument:
# * A list of integers to examine (e.g. ( 50, 25, 33, 22 ) )
# Returns:
# * The provided integers, sorted as described above (e.g. ( 22, 33, 50, 25 ) )
################################################################################
sub digit_product_steps_sort{

    my @num_steps;

    # Loop over each argument
    foreach my $num (@ARG){
        my $steps = 0;
        my $iterated_num = $num;

        # In case there's a negative
        $iterated_num *= -1
            if($iterated_num < 0);

        # Loop until there's only one digit in the
        # iterated copy of the number
        while(length($iterated_num) > 1){
            my $product = 1;

            # Multiply the digits
            foreach my $digit (split('', $iterated_num)){
                $product *= $digit;
            }

            # Update the iterated number, count this step
            $iterated_num = $product;
            $steps++;
        }

        # Store the original number and the steps
        # required to process it
        push(@num_steps, [ $num, $steps ]);
    }

    return(
        # 2: Make a list of the original values
        # from the now-sorted results
        map(
            $_->[0],
            # 1: Sort the results: if the step counts
            # are equal, sort by original value;
            # otherwise sort by step count
            sort(
                {
                    $a->[1] == $b->[1] ?
                        $a->[0] <=> $b->[0]
                        :
                        $a->[1] <=> $b->[1];
                }
                @num_steps
            )
        )
    );

}



