use strict;
use warnings;

sub is_binary_palindrome {
    my ($N) = @_;
    my $binary_rep = sprintf("%b", $N);
    return $binary_rep eq reverse($binary_rep) ? 1 : 0;
}

# Tests
print is_binary_palindrome(5);  # Output: 1
print is_binary_palindrome(4);  # Output: 0

