#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @number_sets = (
    [ "123", 6 ],
    [ "105", 5 ],
    [ "232", 8 ],
    [ "1234", 10 ],
    [ "1001", 2 ]
);

print("\n");
foreach my $number_set (@number_sets){
    printf(
        "Input: \$str = \"%s\", \$target = %d\nOutput: (%s)\n\n",
        @{$number_set},
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                find_matching_expressions(@{$number_set})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting solely of digits, as well as a target value, place
# operators (+, -, *) within the string to produce expressions that equal the
# target value.  The digits will not be re-ordered, but may be combined into
# multi-digit numbers in-place (i.e. "3+4+5", "34+5", "3+45", "345", etc.)
# Takes two arguments:
# * A string containing the digits to be processed (e.g. "1234")
# * The target value that the supplied digts must be manipulated to equal (e.g.
#   10)
# Returns:
# * A lexicographically sorted list of strings containing expressions made up
#   of digits and operators that result in the target values; this list will be
#   empty if no such strings could be constructed using the supplied digits
#   (e.g. ("1*2*3+4", "1+2+3+4") )
################################################################################
sub find_matching_expressions{
    # This is weird, but it works; X's will be
    # replaced with operators later
    my @digits = split(//,
        join(
            "X",
            split(//, shift())
        )
    );
    my $target = shift();

    # Since digits can be combined to form larger
    # values, the empty string is considered an
    # operator here
    my @operators = ("", "+", "-", "*");
    my @matches;

    ##################################################
    # Recursively evaluate expressions concatenated
    # from the available digits and operators.
    # Takes the index of the last operator position
    # in @digits as its initial argument.
    # Receives all other data and stores all output in
    # variables inherited from the caller's scope
    # (@digits, @operators, @matches in particular)
    ##################################################
    my $recursive_evaluator;
    $recursive_evaluator = sub{
        my $index = shift();

        if($index == 1){
            # This is the last index...
            my $str;

            # Apply each operator to the last index
            foreach my $operator (@operators){
                $digits[1] = $operator;

                # Concatenate all digits and operators, skip
                # instances of leading zeros behind an operator,
                # then evaluate the result; storing it if it
                # matches the target
                $str = join("", @digits);
                next
                    if($str =~ m/\D0+\d|^0+\d/);
                push(@matches, $str)
                    if(eval($str) == $target);
            }
        } else{
            # This is not the last index- apply each operator
            # to our given index, then call ourselves on the
            # next index
            foreach my $operator (@operators){
                $digits[$index] = $operator;
                &$recursive_evaluator($index - 2);
            }
        }
    };
    ##################################################
    # End recursive evaluator
    ##################################################

    # Call the recursive evaluator on the index of the
    # last operator in @digits
    &$recursive_evaluator($#digits - 1);

    return(sort(@matches));

}



