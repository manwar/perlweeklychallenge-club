#!/usr/bin/perl

use strict;
use warnings;

my $type = shift @ARGV || 'strong';
my @primes = grep( { ( 1 x $_ ) !~ /^1?$|^(11+?)\1+$/ } 1 .. 101 );
my %first_10 = (
  strong => [],
  weak => [],
);

print "First 10 $type prime numbers:\n";

my $count = 0;
for ( my $n = 1; $n < @primes - 1; $n++ ) {
    my $t = ( $primes[$n] > ( $primes[$n - 1] + $primes[$n + 1] ) / 2 ) ? 'strong' : 'weak';
    next if @{ $first_10{$t} } >= 10;
    push( @{ $first_10{$t} }, $primes[$n] );
    #print "#" . @{ $first_10{$t} } . ": p($n) = $primes[$n]\n" if $type eq $t;
    printf( "%3s: %5s = %2d\n",  "#" . @{ $first_10{$t} }, "p($n)", $primes[$n] ) if $type eq $t;
}
