#!/usr/bin/perl
use strict;
use warnings;

# Usage: ch-1.pl M N a_(1,1) a_(1,2) ... a(M,N) 
# Perl Weekly Challenge #068 Task 1 Zero Matrix

my @matrix;
my ($M, $N);
$M = 4; $N = 3;
@matrix =  ([0, 1, 0, 1] ,[ 1, 0,1, 1] ,[1, 1, 1, 1]);

if ($ARGV[0] and $ARGV[1]) {
    $M = $ARGV[0];
    $N = $ARGV[1];
    @matrix = ();
    die "parameter(s) problem" unless scalar @ARGV == ($M*$N+2);

    for my $i (0..$N-1) {
        my @s = ();
        for my $j (0..$M-1) {
            push @s, $ARGV[$M*$i+$j +2 ];
        }
        push @matrix, \@s ;
    }
}


my @newmatrix;

for my $i (0..$N-1) {
    my @s = ();
    for my $j (0..$M-1) {
        push @s, 1;
    }
    push @newmatrix, \@s;
}


my @zerorow = ();
my @zerocol = ();

for my $i (0..$N-1) {
    for my $j (0..$M-1) {
        if ($matrix[$i][$j] == 0) {
    #   if (${@matrix[$i]}[$j] == 0) {  improve after using warnings
            push @zerorow, $i;
            push @zerocol, $j;
        }
    }
}

sub assignzerorow {
    my $r = $_[0];
    for my $j (0..$M-1) {
        $newmatrix[$r][$j] = 0;
    }
}

sub assignzerocol {
    my $c = $_[0];
    for my $i (0..$N-1) {
        $newmatrix[$i][$c] = 0;
    }
}

print "\n";

for my $i (0..$N-1) {
    for my $j (0..$M-1) {
        print $matrix[$i][$j], " ";
    }
    print "\n";
}

print " * * * * * * * \n";

print "\n";
assignzerorow($_) foreach (@zerorow);
assignzerocol($_) foreach (@zerocol);

for my $i (0..$N-1) {
    for my $j (0..$M-1) {
        print $newmatrix[$i][$j], " ";
    }
    print "\n";
}

