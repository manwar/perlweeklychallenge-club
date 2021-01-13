#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental recursion };
binmode( STDOUT, ":utf8" ) ;

use Carp;
use JSON;

my $json = JSON->new->canonical->pretty->allow_nonref;

my $n = 23;
my @output = collatz($n);
say join ' → ', @output;

exit;

sub collatz ( $n ) {
    $n = int $n;
    croak if $n < 1;
    my @sec;
    if ( $n == 1 ) {
        push @sec, 1;
    }
    elsif ( $n % 2 == 1 ) {    #odd
        my $o = ( 3 * $n ) + 1;
        push @sec, $n, collatz($o);
    }
    elsif ( $n % 2 == 0 ) {    #even
        my $o = $n / 2;
        push @sec, $n, collatz($o);
    }
    return wantarray ? @sec : \@sec;
}
