use Test;

sub most-frequent-letter-pair(Str $s) returns Str {
    my %pairs;

    # Counting frequencies of each pair
    %pairs{.substr($_, 2)}++ for 0..$s.chars - 2;

    # Finding the most frequent pair
    my @sorted-pairs = %pairs.keys.sort({%pairs{$^b} <=> %pairs{$^a} || $^a cmp $^b});
    return @sorted-pairs[0];
}

# Tests
is most-frequent-letter-pair('abcdbca'), 'bc', 'Example 1';
is most-frequent-letter-pair('cdeabeabfcdfabgcd'), 'ab', 'Example 2';
