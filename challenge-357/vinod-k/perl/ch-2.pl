#!/usr/bin/perl

use strict;
use warnings;

sub generate_fractions {
    my ($n) = @_;
    
    my @fractions;
    
    for my $num (1..$n) {
        for my $den (1..$n) {
            push @fractions, [$num, $den];
        }
    }
    
    @fractions = sort {
        my $val_a = $a->[0] / $a->[1];
        my $val_b = $b->[0] / $b->[1];
        $val_a <=> $val_b || $a->[0] <=> $b->[0]
    } @fractions;
    
    my @unique;
    my %seen_values;
    
    for my $frac (@fractions) {
        my $num = $frac->[0];
        my $den = $frac->[1];
        my $value = $num / $den;
        
        if (!exists $seen_values{$value} || $num < $seen_values{$value}) {
            $seen_values{$value} = $num;
            push @unique, [$num, $den];
        }
    }
    
    return @unique;
}

sub print_fractions {
    my ($n) = @_;
    
    print "Input: $n\n";
    print "Output: ";
    
    my @fractions = generate_fractions($n);
    
    for my $i (0 .. $#fractions) {
        my ($num, $den) = @{$fractions[$i]};
        print "$num/$den";
        print ", " if $i < $#fractions;
    }
    print "\n\n";
}

my @test_cases = (3, 4, 1, 6, 5);

foreach my $n (@test_cases) {
    print_fractions($n);
}
