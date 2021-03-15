use v6;
use Memoize;

sub edit-distance (Str $left, Str $right) {
    # If one of the substrings is empty, return the length of the other
    return $right.chars unless $left;
    return $left.chars unless $right;
    my $shortened-left  = substr $left,  0, *-1;
    my $shortened-right = substr $right, 0, *-1;

    # If the last chars are the same, we ignore them
    # and call edit-distance on shortened strings
    return edit-distance $shortened-left, $shortened-right
        if substr($left, *-1) eq substr($right, *-1);

    # Else find the minimum between the three operations
    return 1 + min(
        edit-distance($left,       $shortened-right), #insert
        edit-distance($shortened-left,  $right),      #remove
        edit-distance($shortened-left,  $shortened-right)  #replace
    );
}

memoize("edit-distance");

my @test-pairs = (
    [ < kitten sitting >],
    [ < Monday Friday > ],
    [ < Sunday Saturday > ],
    [ < January February > ],
    [ < November December > ],
    [ < constitutionally anticonstitutional > ],
    [ < LMIjkHFSAE dmqkdjfERZG >],
);
for @test-pairs -> @test {
    my ($str1, $str2) = @test;
    print edit-distance($str1, $str2), " $str1 - $str2\n";
}
