#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @list = ( 1234, 999 );
@list = @ARGV ? @ARGV : @list;

for my $n (@list) {
    my $p = next_palindrome($n);
    say <<"END";
    Input:  $n
    Output: $p
END
}

sub next_palindrome ( $n ) {
    while (1) {
        $n++;
        my $r = 0 + reverse_string($n);
        return $n if $n == $r;
    }
}

sub reverse_string ( $s ) {
    return scalar reverse $s;
}
