#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [ 10, 1000 ],
    [ 7,  1000 ],
    [ 16, 1000 ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \$base = %d, \$limit = %d\nOutput: (%s)\n\n",
        $data_set->[0],
        $data_set->[1],
        join(
            ", ",
            calculate_armstrong_numbers(@{$data_set})
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a numerical base and a limit value, determine which Natural Numbers
# from 0 to the limit are Armstrong Numbers (also known as Narcissistic
# Numbers) which is to say, numbers whose digits in the given numerical base,
# each raised to the power of the number of digits in the number, add up to the
# number itself.
# See also: https://en.wikipedia.org/wiki/Narcissistic_number
# Takes two arguments:
# * A numerical base in which to examine digits within numerical values
#   (e.g. 7)
# * An upper limit that constrains the numbers to be examined (e.g. 1000)
# Returns:
# * A list of Armstrong numbers in the given base below the specified limit
#   (e.g. ( 0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250 ) )
################################################################################
sub calculate_armstrong_numbers{
    use POSIX;

    my $base = shift();
    my $limit = shift();

    my $digits;
    my $i;
    my $sum;

    # Zero is always an Armstrong Number so we
    # start with that
    my @armstrong_numbers = (0);

    # Loop over the numbers from 1 to the limit
    for my $n (1 .. $limit){
        $sum = 0;

        # Calculate the number of digits that make up
        # this number in the specified base
        $digits = floor(log($n)/log($base)) + 1;

        # Sum the values of all the digits in the
        # specified base raised to the power of the
        # number of digits in the number; see also
        # the article linked above
        for $i (0 .. $digits - 1){
            $sum +=
                (
                    ($n % $base ** ($i + 1) - $n % $base ** $i)
                    /
                    ($base ** $i)
                )
                **
                $digits;
        }

        # If the sum calculated above is equal to the
        # number itself, this is an Armstrong Number;
        # store it
        push(@armstrong_numbers, $n)
            if($n == $sum);
    }

    return(@armstrong_numbers);

}



