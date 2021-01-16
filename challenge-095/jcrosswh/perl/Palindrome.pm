package Palindrome;

use strict;
use warnings;

sub is_palindrome {
    my ($this, $N) = @_;

    return '' if !defined($N);
    return 1 if length($N) == 1;

    my $halfway = int(length($N) / 2);
    return 
        first_half($N, $halfway) eq reverse(second_half($N, $halfway));
}

sub first_half {
    my ($N, $halfway) = @_;
    return substr($N, 0, $halfway);
}

sub second_half {
    my($N, $halfway) = @_;
    return substr($N, $halfway + length($N) % 2);
}

1;