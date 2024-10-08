#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{sum0};

my @examples = (

    "17893729974",
    "4137 8947 1175 5904",
    "4137 8974 1175 5904",
);

for my $input (@examples) {
    my $output = luhns_algorithm($input);

    say <<"END";
    Input:  "$input"
    Output: $output
END
}

sub luhns_algorithm ($str) {
    $str =~ s/\D+//gmx;
    my @str     = split //, $str;
    my $payload = pop @str;
    my $x   = 0;
    my $sum = 0;
    for my $i ( reverse 0 .. -1 + scalar @str ) {
        my $d = $str[$i];
        $d *= 2 if $x % 2 == 0;
        my $e = sum0( split //, $d );
        $sum += $e;
        $x++;
    }
    return  ( ( ( ( $sum + $payload ) % 10 ) == 0 ) ? 'true' : 'false' );
}
