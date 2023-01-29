#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw/sum/;
use Algorithm::Combinatorics qw[ variations_with_repetition ];


print "Please enter a integer number > 0: ";
my $input = <STDIN>;
chomp $input;
die 'input not valid'
    unless $input =~ /^\d+$/;

my $tot_penny = $input;
my $max_piles = $tot_penny;
my @piles;


foreach my $max_col (reverse(0..$max_piles-1)) {
    my @seed_data = map { 1 }
                (0..$max_col);
    my $remaining_penny = $tot_penny - sum(@seed_data);

    my @n = (0..$remaining_penny);

    my $iter = variations_with_repetition( \@n, $#seed_data+1 );
    while (my $tupla = $iter->next) {
        next if sum(@$tupla) != $remaining_penny
                or
                scalar @$tupla > 1 and scalar map { $tupla->[$_] > $tupla->[$_+1] ? 1 : ()}
                                                (0..(scalar @$tupla)-2);
        my @data = map { int($seed_data[$_] + $tupla->[$_] ) }
                     (0..$#seed_data);
        push @piles, \@data;
    }
}

printf "Since \$n=%s, there are %s ways of stacking %s pennies in ascending piles:", $tot_penny, scalar @piles, $tot_penny;
printf "\n\t%s", join ' ', @$_
    foreach @piles;
