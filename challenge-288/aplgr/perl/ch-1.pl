use strict;
use warnings;

sub is_palindrome {
    my ($num) = @_;
    return $num eq reverse($num);
}

sub find_closest {
    my ($lower, $upper, $original) = @_;
    return $lower if is_palindrome($lower) && $lower != $original;
    return $upper if is_palindrome($upper) && $upper != $original;
    return find_closest($lower-1, $upper+1, $original) if $lower > 0;
    return $upper + 1
}

sub closest_palindrome {
    my ($str) = @_;
    my $num = int($str);
    return find_closest($num -1, $num + 1, $num);
}

1;