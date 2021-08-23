# Case 1, one common element
my @a = 1, 2, 5, 3, 4;
my @b = 4, 6, 7, 8, 9;

# Case 2, no common elements
# my @a = 1, 3, 5, 7, 9;
# my @b = 0, 2, 4, 6, 8;

# Case 3, two common elements
# my @a = 1, 2, 5, 3, 4, 6;
# my @b = 4, 6, 7, 8, 9;

# Short output

say +!(@a ∩ @b);

# Long output

given @a ∩ @b {
    when .elems == 1 {
        say "0 as the given two sets have common member $_.";
    }
    when .elems == 0 {
        say "1 as the given two sets do not have common members.";
    }
    default {
        say "0 as the given two sets have common members {$_.keys.sort.join(', ')}.";
    }
}
