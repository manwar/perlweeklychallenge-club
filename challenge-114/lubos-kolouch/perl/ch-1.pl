sub next_palindrome {
    my $n = shift;
    while (1) {
        $n += 1;
        return $n if $n eq reverse $n;
    }
}

# Test
print next_palindrome(1234), "\n";    # Output: 1331
