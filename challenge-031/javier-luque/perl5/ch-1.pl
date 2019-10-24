#!/usr/bin/perl
use strict;
use warnings;
use feature qw/ say /;

# A few test cases
for my $statement ('1/0', '1/2', '0/100') {
    my $answer = divide_by_zero_check($statement);
    (defined($answer)) ?
            say $statement . ' - ' . $answer :
            say $statement . ' - ' . 'divide by 0 error';
}

# Return the $answer or undef if we can't divide by 0
sub divide_by_zero_check {
    my $answer;
    eval { $answer = eval shift; };
    return $answer;
}


