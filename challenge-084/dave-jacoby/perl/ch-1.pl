#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my $num = shift @ARGV;
$num //= -1234;

reverse_integer($num);

sub reverse_integer( $number ) {
    my $num = int $number;
    if ( $num > 2147483647 || $num < -2147483648 ) {
        say 0;
        return;
    }
    my $sba = join '', reverse split //, abs $num;
    my $mun = $num >= 0 ? $sba : 0 - $sba;
    say $mun;
}
