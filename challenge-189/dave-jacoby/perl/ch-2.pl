#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Carp;
use List::Util qw{ max uniq };

my @input = (
    [ 1, 3, 3, 2 ],
    [ 1, 2, 1, 3 ],
    [ 1, 3, 2, 1, 2 ],
    [ 1, 1, 2, 3, 2 ],
    [ 2, 1, 2, 1, 1 ],
);

for my $input (@input) {
    my @x = $input->@*;
    my $x = join ', ', @x;
    my @o = array_degree(@x);
    my $o = join ', ', @o;
    say <<"END";
    Input:  \@array = ($x) 
    Output: ($o)
END
}

sub array_degree ( @array ) {
    my @output;
    my %hash;
    for my $i ( uniq sort @array ) {
        my $j = scalar grep { $_ == $i } @array;
        $hash{$i} = $j;
    }
    my $max = max values %hash;
    my @n   = grep { $max == $hash{$_} } uniq sort @array;
    for my $n (@n) {
        for my $i ( 0 .. -1 + scalar @array ) {
            for my $j ( $i + 1 .. -1 + scalar @array ) {
                my @sub = @array[ $i .. $j ];
                my $c   = scalar grep { $_ == $n } @sub;
                next if $sub[0] ne $n;  # starts with the digit
                next if $sub[-1] ne $n; # ends with the digits
                next if $c != $max;     # contains all the occurances
                push @output, [@sub];
            }
        }
    }
    @output = sort { scalar $a->@* <=> $b->@* } @output;
    return $output[0]->@*;
}
