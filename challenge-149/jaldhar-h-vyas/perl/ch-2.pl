#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw / true /;
no warnings qw/ experimental::builtin /;

sub base($number, $base) {
    my @digits = (0 .. 9, 'A' .. 'Z');
    my @result;

    while ($number > ($base - 1)) {
        my $digit = $number % $base;
        push @result, $digits[$digit];
        $number /=  $base;
    }

    push @result, $digits[$number];

    my $result = join q{}, reverse @result;
    $result =~ s/^[0]+//;
    return $result;
}

sub unique(@arr) {
    my %elems;
    for (@arr) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my ($base) = @ARGV;
my $max = 0;
my $n = 1;

while(true) {
    my $square = base($n * $n, $base);
    if (length($square) > $base) {
        last;
    } 

    my @digits = split //, $square;

    if (scalar @digits == scalar unique(@digits)) {
        $max = $square;
    }

    $n++;
}

say $max;

