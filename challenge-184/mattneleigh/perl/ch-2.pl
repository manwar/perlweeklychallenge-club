#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ "a 1 2 b 0", "3 c 4 d" ],
    [ "1 2", "p q r", "s 3", "4 5 t" ]
);

print("\n");
foreach my $list (@lists){
    my @digit_lists = ();
    my @letter_lists = ();

    # Loop over each string in this list
    foreach my $string (@{$list}){
        # Add an empty list to each category
        push(@digit_lists, []);
        push(@letter_lists, []);

        # Place each character in the last character
        # list for its category
        foreach my $char (split(' ', $string)){
            if($char =~ m/\d/){
                push(@{$digit_lists[$#digit_lists]}, $char);
            } else{
                push(@{$letter_lists[$#letter_lists]}, $char);
            }
        }

        # Strip out the added lists if they're still empty
        pop(@digit_lists)
            unless(@{$digit_lists[$#digit_lists]});
        pop(@letter_lists)
            unless(@{$letter_lists[$#letter_lists]});
    }

    # Very complex output
    printf(
        "Input: \@list = (%s)\nOutput: [%s] and [%s]\n\n",
        join(
            ", ",
            map(sprintf("'%s'", $_), @{$list})
        ),
        join(
            ", ",
            map(
                sprintf("[%s]", join(",", @{$_})),
                @digit_lists
            )
        ),
        join(
            ", ",
            map(
                sprintf(
                    "[%s]",
                    join(
                        ",",
                        map("'$_'", @{$_})
                    )
                ),
                @letter_lists
            )
        ),
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



