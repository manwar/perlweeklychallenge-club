#!/usr/bin/perl
use strict;
use warnings;

my $N         = 4;
my @gray_code = ( 0, 1 );

for my $i ( 2 .. $N ) {
    my @rev_gray_code = reverse @gray_code;
    @gray_code     = map { "0$_" } @gray_code;
    @rev_gray_code = map { "1$_" } @rev_gray_code;
    push @gray_code, @rev_gray_code;
}

@gray_code = map { oct("0b$_") } @gray_code;
print join( ", ", @gray_code ), "\n";
