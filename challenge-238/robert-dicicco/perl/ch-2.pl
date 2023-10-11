#!/usr/bin/env perl
=begin comment
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-10
Challenge 238 Task 02 Persistence Sort ( Perl )
----------------------------------------
=cut
use v5.38;
use List::Util qw/product/;

my @myints = ([15, 99, 1, 34],[50, 25, 33, 22]);

sub Reduce ( $num ) {
    my $steps = 0;
    while($num > 9) {
        my @arr = split('',$num);
        $num = product(@arr);
        $steps++;
    }
    return $steps;
}

for my $mints (@myints) {
    say "Input: \@int = [@$mints]";
    my $cnt = 0;
    my %h;
    while ($cnt < scalar @$mints) {
        my $retval = Reduce($mints->[$cnt]);
        $h{$mints->[$cnt]} = $retval;
        $cnt++;
    }

    print "Output : [";
    foreach my $key (sort { $h{$a} <=> $h{$b} or $a cmp $b } keys %h) {
        printf "%d ", $key;
    }
    say "]\n";
}

=begin comment
----------------------------------------
SAMPLE OUTPUT

perl .\Persistence.pl

Input: @int = [15 99 1 34]
Output : [1 15 34 99 ]

Input: @int = [50 25 33 22]
Output : [22 33 50 25 ]
----------------------------------------
=cut


