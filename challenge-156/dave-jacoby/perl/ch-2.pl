#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use List::Util qw{ sum0 };
use Scalar::Util qw{ looks_like_number };

my $n = 12;
GetOptions( 'number=i' => \$n );
croak "Not Greater than 0" unless $n > 0;

my $w = is_weird($n);
say <<"END";
    Input:  \$n = $n
    Output: $w
END

sub is_weird ( $n ) {
    my $m       = $n;
    my @factors = grep { $n % $_ == 0 } 1 .. $n - 1;
    my $sum     = sum0 @factors;
    my $w       = subset_sum( $n, \@factors );
    return ( $sum > $n && !$w ) ? 1 : 0;
}

sub subset_sum ( $n, $factors, $i = 0, @values ) {
    if ( !defined $factors->[$i] ) {
        my $sum = sum0 @values;
        return $n == $sum ? 1 : 0;
    }
    my @o;
    return 1 if subset_sum( $n, $factors, $i + 1, @values, $factors->[$i] );
    return 1 if subset_sum( $n, $factors, $i + 1, @values, 0 );
    return 0;
}

