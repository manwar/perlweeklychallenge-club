#!/usr/bin/perl

use strict;
use warnings;

sub kaprekar_steps {
    my ($n) = @_;
    
    return 0 if $n == 6174;
    
    my %seen;
    my $steps = 0;
    
    while ($n != 0 && !$seen{$n}++) {
        my $s = sprintf("%04d", $n);
        my @digits = split('', $s);
        my @desc = sort { $b cmp $a } @digits;
        my @asc  = sort { $a cmp $b } @digits;
        
        my $desc_num = join('', @desc);
        my $asc_num  = join('', @asc);
        
        $n = $desc_num - $asc_num;
        $steps++;
        
        last if $n == 6174;
    }
    
    return $n == 6174 ? $steps : -1;
}

sub show_iterations {
    my ($input, $expected_steps) = @_;
    
    print "\nInput: $input\n";
    print "Output: ", kaprekar_steps($input), "\n";
    
    return if kaprekar_steps($input) == 0 || kaprekar_steps($input) == -1;
    
    print "Iteration 1: ";
    my $current = $input;
    my $step = 1;
    
    while ($current != 6174 && $step <= $expected_steps) {
        my $s = sprintf("%04d", $current);
        my @digits = split('', $s);
        my @desc = sort { $b cmp $a } @digits;
        my @asc  = sort { $a cmp $b } @digits;
        
        my $desc_num = join('', @desc);
        my $asc_num  = join('', @asc);
        my $next = $desc_num - $asc_num;
        
        printf "%04d - %04d = %04d\n", $desc_num, $asc_num, $next;
        
        $current = $next;
        $step++;
        
        if ($current != 6174) {
            print "Iteration $step: ";
        }
    }
    print "\n";
}

my @examples = (3524, 6174, 9998, 1001, 9000, 1111);
my @expected = (3, 0, 5, 4, 4, -1);

foreach my $i (0 .. $#examples) {
    show_iterations($examples[$i], $expected[$i]);
}
