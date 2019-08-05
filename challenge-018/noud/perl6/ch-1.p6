# Write a script that takes 2 or more strings as command line parameters and
# print the longest common substring. For example, the longest common substring
# of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC” of length 3.
# Other common substrings are “A”, “AB”, “B”, “BA”, “BC” and “C”. Please check
# this wiki page for details.


# The subroutine finds the longest common substrings (could be more than one)
# with dynamical programming. The algorithm runs in O(ij) time.
sub lcs($s1, $s2) {
    my $z = 0;
    my @ret = ();
    my @l[$s1.chars, $s2.chars];

    for 0..($s1.chars - 1) -> $i {
        for 0..($s2.chars - 1) -> $j {
            @l[$i; $j] = 0;
            if ($s1.comb[$i] === $s2.comb[$j]) {
                if ($i == 0 || $j == 0) {
                    @l[$i; $j] = 1;
                } else {
                    @l[$i; $j] = @l[$i-1; $j-1] + 1;
                }

                if (@l[$i; $j] > $z) {
                    $z = @l[$i; $j];
                    @ret = ($s1.substr($i - $z + 1, $z));
                } elsif (@l[$i; $j] == $z) {
                    @ret.append($s1.substr($i - $z + 1, $z));
                }

            }
        }
    }

    return @ret;
}


multi MAIN('test') {
    use Test;
    is lcs("ababc", "babca"), <babc>;
    is lcs("abac", "acab"), <ab ac>;
}
