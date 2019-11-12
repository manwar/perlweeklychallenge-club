#!/usr/bin/perl
use strict;
use warnings;
use feature qw /say/;
use Data::Dumper;

my @array = (0..10);
my $count = 0;
my %hash  = map {$_ => ++$count} 'a'..'j';

say "Array slice :  @array[3..7]";
say "Hash slice 1: ", join ' ', %hash{'b', 'd', 'c'};
say "Hash slice 2: ", join ' ', %hash{'b'..'d'};
say "Hash slice 3: ", join ' ', @hash{'b'..'d'};
say "Hash slice 4: ", join ' ', @hash{qw/c b c d/};

# Array slice a l-value
my @new_array = (1, 2);
@new_array[2, 3] = @array[6, 7];
say "New array: ";
say Dumper \@new_array;

# Hash slice as l-value:
my @keys = qw/c d e/;
my %new_hash = %hash{@keys}; # Perl 5.20 and above
say "New hash: ";
say Dumper \%new_hash;
my %new_hash2;
@new_hash2{@keys} = @hash{@keys};
say "New hash2: ";
say Dumper \%new_hash2;
