#!perl6
# Task 2 Challenge 053 Solution by kevincolyer
# Vowel Strings
# Write a script to accept an integer 1 <= N <= 5 that would 
# print all possible strings of size N formed by using only vowels 
# (a, e, i, o, u).
# The string should follow the following rules:
# 'a’ can only be followed by ‘e’ and ‘i’.
# ‘e’ can only be followed by ‘i’.
# ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
# ‘o’ can only be followed by ‘a’ and ‘u’.
# ‘u’ can only be followed by ‘o’ and ‘e’.
# For example, if the given integer N = 2 then script should print 
# the following strings:
# aeaieiiaioiuieoaouuoue

my %chain = 'a' => <e i>,
            'e' => <i>,
            'i' => <a e o u>,
            'o' => <a u>,
            'u' => <o e>;

sub possibleStrings(Int $size) {
    die "1 <= size <= 5" unless 1 <= $size <= 5;
    my @solutions;
    for %chain.keys -> $start {
        @solutions.append: vowelChains($start,$size);
    } 
    return @solutions.sort;
}

sub vowelChains($start,$depth) {
    return '' if $depth == 0;
    my @solutions;
    for %chain{$start}.values -> $next {
        # say "$start -> $next";
        @solutions.append: $start ~ $_ for vowelChains($next,$depth-1);
    }
    return @solutions.unique.sort;

}

sub MAIN($size) {
    possibleStrings($size)>>.say;
}
