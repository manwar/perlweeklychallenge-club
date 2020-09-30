#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

use Data::Dumper;

my @new_array;
my $count = 0;

my $string = "Perl Weekly Challenge";
say "Before: $string";

my @array = split //, $string;

foreach (@array){
    if($_ eq 'e'){
        $_ =~ s/e/E/;
        $count++;		
	}
	push @new_array, $_;
}
say "After: ".join('', @new_array);
say "Letter 'e' occured $count times.";
