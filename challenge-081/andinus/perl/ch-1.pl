#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl <string> <string>"
    unless scalar @ARGV == 2;

my $A = shift @ARGV;
my $B = shift @ARGV;

# We assume length($B) is greater than length($A).
unless (length($B) > length($A)) {
    my $tmp = $A;
    $A = $B;
    $B = $tmp;
}

# Check if common base string is even possible.
my (%chars_in_A, %chars_in_B);
$chars_in_A{$_} = 1 foreach split //, $A;
$chars_in_B{$_} = 1 foreach split //, $B;
foreach my $char (sort keys %chars_in_A) {
    last if exists $chars_in_B{$char} ;
    print "No common base string.\n" and exit 0;
}

# Get all common divisors.
my %divisors_of_A = divisors(length($A));
my %divisors_of_B = divisors(length($B));
my @common_divisors;
foreach my $num (sort { $a <=> $b } keys %divisors_of_A) {
    push @common_divisors, $num
        if exists $divisors_of_B{$num};
}

# Returns all divisors of a number.
sub divisors {
    my $n = shift @_;
    my %divisors;
    foreach my $i ( 1 ... $n){
        if ($n % $i == 0) {
            $divisors{$i} = 1;
        }
    }
    return %divisors;
}

my @common;

foreach my $num (@common_divisors){
    my $tmp;
    my $base = substr($A, 0, $num);
    foreach (1 ... length($B) / $num) {
        $tmp .= $base;
    }
    push @common, $base if $tmp eq $B;
}

print "No common base string.\n" and exit 0
    unless scalar @common;
print join(', ', @common), "\n";
