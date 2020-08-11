# Show multiple arrays content
#
# You are given two or more arrays. Write a script to display values of each
# list at a given index.
#
# For example:
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? £ $ % ^ & * ]
#
# We expect the following output:
#
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *

my @arr1 = <I L O V E Y O U>;
my @arr2 = <2 4 0 3 2 0 1 9 5 6 7 8>;
my @arr3 = <! ? £ $ % ^ & * ( )>;

sub print_intertwined(**@arrs) {
    my $sub_arr_max = max(($_.elems for @arrs));
    @arrs = ((|$_, " " xx $sub_arr_max - $_.elems).flat for @arrs);
    for [Z] @arrs -> @arr {
        say join(" ", @arr);
    }
}

print_intertwined(@arr1, @arr2, @arr3);
