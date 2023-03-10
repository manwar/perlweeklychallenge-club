#!/usr/bin/perl

use strict;
use warnings;

sub is_smooth {
    my $n = shift;
    while ( $n % 2 == 0 ) { $n /= 2; }
    while ( $n % 3 == 0 ) { $n /= 3; }
    while ( $n % 5 == 0 ) { $n /= 5; }
    return $n == 1;
}

sub generate_smooth_numbers {
    my $n              = shift;
    my @smooth_numbers = (1);
    my $candidate      = 1;
    while ( @smooth_numbers < $n ) {
        $candidate++;
        push @smooth_numbers, $candidate if is_smooth($candidate);
    }
    return @smooth_numbers;
}

my $n              = shift || 10;
my @smooth_numbers = generate_smooth_numbers($n);

print "First $n 5-smooth numbers:\n";
print join( ", ", @smooth_numbers ), "\n";

use Test::More;

my @expected = ( 1, 2, 3, 4, 5, 6, 8, 9, 10, 12 );
is_deeply( [ generate_smooth_numbers(10) ], \@expected, "generate_smooth_numbers(10)" );

done_testing;
