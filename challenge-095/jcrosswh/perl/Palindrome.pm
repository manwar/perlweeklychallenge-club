package Palindrome;

use strict;
use warnings;

sub is_palindrome {
    my ($this, $N) = @_;
    
    return 0 if !defined($N);
    return 1 if length($N) == 1;
    
    foreach my $index (0..int(length($N) / 2)) {
        return 0
            if (substr($N, $index, 1) != substr($N, length($N) - 1 - $index, 1));
    }
    return 1;
}

1;