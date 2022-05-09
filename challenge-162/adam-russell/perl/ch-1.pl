use strict;
use warnings;
##
# Write a script to generate the check digit of a given ISBN-13 code.
##
sub isbn_check_digit{
    my($isbn) = @_;
    my $i = 0;
    my @weights = (1, 3);
    my $check_sum = 0;
    my $check_digit;
    map {$check_sum += $_ * $weights[$i]; $i = $i == 0 ? 1 : 0} split(//, $isbn);
    $check_digit = $check_sum % 10;
    return 10 - $check_digit;
}

MAIN:{
    print isbn_check_digit(978030640615) . "\n";
}