# Vowel Strings
#
# Write a script to accept an integer 1 <= N <= 5 that would print all possible
# strings of size N formed by using only vowels (a, e, i, o, u).
#
# The string should follow the following rules:
#
#     ‘a’ can only be followed by ‘e’ and ‘i’.
#     ‘e’ can only be followed by ‘i’.
#     ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
#     ‘o’ can only be followed by ‘a’ and ‘u’.
#     ‘u’ can only be followed by ‘o’ and ‘e’.
#
# For example, if the given integer N = 2 then script should print the
# following strings:
#
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue

my %rules = 'a' => ['e', 'i'],
            'e' => ['i'],
            'i' => ['a', 'e', 'o', 'u'],
            'o' => ['a', 'u'],
            'u' => ['o', 'e'];

sub vowel-strings($n) {
    if ($n == 1) {
        return [['a'], ['e'], ['i'], ['o'], ['u']];
    }

    my @ret = [];
    for vowel-strings($n - 1) -> @a {
        for %rules{@a[*-1]}[*;*] -> $e {
            @ret.push([|(@a), $e]);
        }
    }
    return @ret;
}

sub MAIN($n) {
    $_.say for vowel-strings($n).map({.join});
}
