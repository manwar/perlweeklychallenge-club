sub next_same_bits {
    my $n        = shift;
    my $one_bits = unpack( "%32b*", pack( "N", $n ) );
    while (1) {
        $n += 1;
        return $n if unpack( "%32b*", pack( "N", $n ) ) == $one_bits;
    }
}

# Test
print next_same_bits(3), "\n";    # Output: 5
