#!/usr/bin/perl
use 5.020;
use warnings;

sub base {
    my ($number, $base) = @_;
    my @digits = (0 .. 9, 'A' .. 'Z');
    my @result;
    while ($number > ($base - 1)) {
        my $digit = $number % $base;
        push @result, $digits[$digit];
        $number /=  $base;
    }
    push @result, $digits[$number];

    return join '', reverse @result;
}

sub is_harshad {
    my ($n) = @_;
    my $total = 0;
    my @digits = split //, $n;
    for my $digit (@digits) {
        $total += $digit;
    }

    return  @digits == $total;
}

sub is_sdn {
    my ($n) = @_;

    if (!is_harshad($n)) {
        return undef;
    }

    my @digits = split //, $n;

    my %count;
    for my $i (0 .. scalar @digits - 1) {
        $count{ $digits[$i] }++;
    }

    for my $i (0 .. scalar @digits - 1) {
        if (!exists $count{$i}) {
            next;
        }
        if ($count{$i} != $digits[$i]) {
            return undef;
        }
    }

    return 1;
}

my @sdns;

for my $base (4 .. 5) {
    for my $i (10 ** ($base - 2) .. 10 ** ($base - 1) - 1) {
        my $n = base($i, $base);
        if (is_sdn($n)) {
            push @sdns, $n;
        }
        if (scalar @sdns == 3) {
            last;
        }
    }
}

say join q{, }, @sdns;