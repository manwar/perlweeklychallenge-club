#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @times = qw{
    ?5:00
    ?3:00
    1?:00
    2?:00
    12:?5
    12:5?
};

for my $time (@times) {
    my $output = digital_clock($time);
    say <<"END";
    Input:  \$time = '$time'
    Output: $output
END
}

sub digital_clock ( $input ) {
    my $valid = '';
    for my $i ( 0 .. 9 ) {
        my $j = $input;
        $j =~ s/\?/$i/mx;
        my ( $h, $m ) = split m{:}, $j;
        return $valid if $h > 23;
        return $valid if $m > 59;
        $valid = $i;
    }
    return $valid;
}
