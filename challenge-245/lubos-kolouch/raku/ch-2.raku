use Test;

sub largest-multiple-of-three(@ints) {
    # Sort in descending order
    @ints = @ints.sort({$^b cmp $^a});
    my $sum = [+] @ints;

    # Function to remove the smallest element with a specific remainder
    sub remove-smallest(Int $remainder) {
        for @ints.keys.reverse -> $i {
            if @ints[$i] % 3 == $remainder {
                @ints.splice($i, 1);
                return True;
            }
        }
        return False;
    }

    # Adjust the list to make the sum of its digits divisible by 3
    if $sum % 3 == 1 {
        unless remove-smallest(1) {
            remove-smallest(2) && remove-smallest(2);
        }
    } elsif $sum % 3 == 2 {
        unless remove-smallest(2) {
            remove-smallest(1) && remove-smallest(1);
        }
    }

    $sum = [+] @ints;
    return @ints && $sum % 3 == 0 ?? @ints.join('').Int !! -1;
}

# Test Cases
is largest-multiple-of-three([8, 1, 9]), 981, 'Example 1';
is largest-multiple-of-three([8, 6, 7, 1, 0]), 8760, 'Example 2';
is largest-multiple-of-three([1]), -1, 'Example 3';

done-testing;
