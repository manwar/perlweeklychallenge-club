#!/usr/bin/perl
# The Weekly Challenge 169
# Task 1 Brilliant Numbers
use v5.24.0;
use warnings;

my $req = $ARGV[0] || 20;

my @prime = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 
             41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97);

die "You're asking too many, or I am too little!\n" 
    if $req > 241;  # 21*20/2 +  21 + 4*3/2 + 4


my $pt = ceil( ( sqrt(8*$req-79) +7 )/2 ) - 1;

my @brilliant = (-1, 4, 6, 9, 10, 14, 15, 21, 25, 35, 49);

my @temp;


for my $i (4..$pt) {
    for my $j ($i..24) {
        my $product = $prime[$i]*$prime[$j];
        push @temp, $product;
    }
}

push @brilliant, sort {$a<=>$b} @temp;

say join ", ", @brilliant[1..$req];


