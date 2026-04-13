#!/usr/bin/perl
use 5.038;
use warnings;
use English;

sub factorize {
    my ($n) = @_;
    my @primeFactors;

    while ($n % 2 == 0) {
        push @primeFactors, 2;
        $n /=  2; 
    } 
     
    for (my $i = 3; $i <= sqrt $n; $i += 2)  { 
        while ($n % $i == 0) { 
            push @primeFactors, $i; 
            $n /= $i; 
        } 
    } 
     
    if ($n > 2) { 
        push @primeFactors, $n;
    }

    return @primeFactors;
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return grep { --$elems{$_} == 0 } @list;

}

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <number> <mode>
  
    <number>    a positive integer
    <mode>      0 or 1
-USAGE-
    exit(0);
}

if (scalar @ARGV != 2) {
    usage;
}

my ($number, $mode) = @ARGV;

if ($number < 1) {
    usage;
}

if ($mode != 0 && $mode != 1) {
    usage;
}

if ($mode == 0) {
    say scalar unique(factorize($number));
} else {
    say scalar factorize($number);
}