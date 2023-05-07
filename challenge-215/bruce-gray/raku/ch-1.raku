sub task1 { +@^words.grep: { not [le] .comb } }

# The single line above is my offical solution.

# But wait! The task description technically
# specifies an (un?)important difference:
#       Write a script to remove all words
#       not sorted alphabetically
#       and print the number of words in the list
#       that are not alphabetically sorted.
# That `remove` is not reflected in the example output,
# but I did it here wanyway, for maximum exactitude (or something).
sub task1_more_correct ( @words --> UInt ) { # Also modifies the @words input array!!!

    # Locate the positions of the unwanted elements.
    my @indexes_to_delete = @words.grep: :k, { not [le] .comb };

    # Remove the unwanted, modifying the input array.
    # Must be done backwards, to prevent shifting index numbers.
    @words.splice($_, 1) for @indexes_to_delete.reverse;

    return +@indexes_to_delete;
}


my @tests =
    ( <abc xyz tsu> , 1 ),
    ( <rat cab dad> , 3 ),
    ( <x y z>       , 0 ),

    ( <aaa bbb ccc> , 0 ),
;
use Test;
plan 2 * @tests;
for @tests -> (@in,  $expected) {
    is   task1(@in), $expected, "task1 @in[]";
}

for @tests -> (@in is copy,  $expected) { # `is copy` needed; it allows the sub to modify the array.
    is task1_more_correct(@in), $expected, "task1_more_correct @in[]";
}
