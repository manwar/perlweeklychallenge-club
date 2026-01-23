#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = ( 3, 4, 1, 6, 5 );

print("\n");
foreach my $int (@ints){
    my $output_string;

    { # Begin scope-limiting block
        my $fracs_per_line = 10;
        my $indent = " " x 8;
        my $pattern = $int == 1 ?
                "%3s"
                :
                "%"
                .
                (int(log($int)/log(10)) + int(log($int - 1)/log(10)) + 3)
                .
                "s";

        my @fractions = all_unique_fractions($int);

        if(scalar(@fractions) > $fracs_per_line){
            # Wrap fractions to multiple lines
            $output_string = "";

            while(@fractions){
                # Pad with leading spaces if this is not the
                # first line
                $output_string .= $indent
                    if($output_string);

                # Make a line out of the desired number of
                # fractions, or all of them if fewer than
                # that remain
                $output_string .= join(
                    ", ",
                    map(
                        sprintf($pattern, $_),
                        splice(@fractions, 0, $fracs_per_line)
                    )
                );

                # Add a newline if this is not the last line
                $output_string .= "\n"
                    if(@fractions);
            }
        } else{
            # Fractions can occupy a single line
            $output_string = join(
                ", ",
                map(
                    sprintf($pattern, $_),
                    @fractions
                )
            );
        }

    } # End scope-limiting block

    printf("Input: \$int = %d\nOutput: %s\n\n", $int, $output_string);
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer $n, generate all unique fractions that make use of
# all integers from 1 to $n in both the numerator and the denominator, in
# ascending order (i.e. 1/$n, 1/($n-1) ... 2/$n, 2,($n-1) ... 1/1 ... ($n-1)/2,
# $n/2 ... ($n-1)/1 ... $n/1).  If any fractions have the same numerical value
# (e.g. 1/2, 2/4) however, only the one with the smallest numerator will be
# included in the list.
# Takes one argument:
# * The integer to process (e.g. 4)
# Returns:
# * A list of fractions that meet the criteria above (e.g. (1/4, 1/3, 1/2, 2/3,
#   3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1) )
################################################################################
sub all_unique_fractions{
    my $n = shift();

    my $i;
    my $j;
    my @fractions;

    { # Begin scope-limiting block
        my $value;
        my %values;

        # Generate every possible unique fraction
        # involving numerators and denominators
        # from 1 to $n that are less than 1
        for $i (1 .. $n - 1){
            for $j ($i + 1 .. $n){
                # If this value has not been seen before,
                # mark it as seen and store it along with the
                # numerator and denominator
                $value = $i / $j;
                unless($values{$value}){
                    $values{$value} = 1;
                    push(
                        @fractions,
                        [ $value + 0, $i, $j ]
                    );
                }
            }
        }

    } # End scope-limiting block

    # Sort the fractions in ascending order by
    # numerical value
    @fractions = sort({ $a->[0] <=> $b->[0] } @fractions);

    # Construct the output list- which consists
    # of the computed fractions, their inverses
    # in reverse order, and a value equal to 1 in
    # between, which is present in all possible
    # outputs
    return(
        map(
            $_->[1] . "/" . $_->[2],
            @fractions
        ),
        "1/1",
        map(
            $_->[2] . "/" . $_->[1],
            @fractions[reverse(0 .. $#fractions)]
        )
    );

}



