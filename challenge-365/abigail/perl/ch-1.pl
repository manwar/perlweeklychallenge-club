#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

my sub digit_sum ($input) {
    my $sum = 0;
    $sum += $_ for split // => $input;
    $sum;
}

while (<>) {
    my ($str, $count) = /^([a-z]+) \s+ ([1-9][0-9]*)/x or next;
    $str =~ s/([a-z])/ord ($1) - ord ('a') + 1/eg;
    $str =  digit_sum $str for 1 .. $count;
    say $str;
}

__END__
