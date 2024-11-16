#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 2, 3, 1, 1, 4 ],
    [ 2, 3, 0, 4 ],
    [ 2, 0, 0, 4 ],

    # Additional test cases
    [ 4, 0, 0, 0, 0 ],
    [ 0, 0, 5, 0, 0 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        minimum_jumps(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of positive integers, find the minimum number of jumps required
# to reach the end of the list, where the value of each integer represents the
# maximum jump distance possible from that location
# Takes one argument:
# * The list of integers to examine (e.g. ( 2, 3, 1, 1, 4 ) )
# Returns:
# * The minimum number of jumps required to reach the end of the list (e.g. 2 )
#   - or -
# * -1 if reaching the end of the list is not possible
################################################################################
sub minimum_jumps{

    # Just call the recursive jumper at index
    # 0
    return(_recursive_jumper([ @ARG ], 0));

}



################################################################################
# Given a list of positive integers and a jumping-off point, find the minimum
# number of jumps required to reach the end of the list, where the value of
# each integer represents the maximum jump distance possible from that
# location; this should only be called by minimum_jumps() (see above)
# Takes two arguments:
# * The list of integers to examine (e.g. ( 2, 3, 1, 1, 4 ) )
# * The index of the next jumping-off point (e.g. 0 )
# Returns:
# * The minimum number of jumps required to reach the end of the list from the
#   specified jumping-off point (e.g. 2 )
#   - or -
# * -1 if reaching the end of the list is not possible from the specified point
################################################################################
sub _recursive_jumper{
    use List::Util qw(min);

    my ($list, $index) = @ARG;

    my @jumps;
    my $max_jump = $list->[$index];
    my $next_jump;
    my $next_index;
    my $rval;

    # See how far ahead we can jump, taking
    # into account the value at this index
    # and the size of the list
    $max_jump = $index + $max_jump > $#$list ?
        $#$list - $index
        :
        $max_jump;

    # Examine each possible jump from here-
    # working backward to try the farther
    # jumps first
    for $next_jump (0 .. $max_jump - 1){
        $next_index = $index + ($max_jump - $next_jump);

        # Store 1 (one more jump) if we're at the end
        # of the list
        if($next_index == $#$list){
            return(1);
        }

        # Can't jump from there if the next value is
        # zero
        next
            if($list->[$next_index] == 0);

        # Run ourselves again on this sub-jump
        $rval = _recursive_jumper($list, $next_index);

        # Store the sub-jump count, plus one, unless
        # that sub-jump hit nothing but zero
        push(@jumps, $rval + 1)
            unless($rval == -1);
    }

    # If we had valid jumps, return the smallest
    # of them, otherwise return -1 (all sub-jumps
    # were to zeros)
    return(
        @jumps ?
            min(@jumps)
            :
            -1
    );

}



