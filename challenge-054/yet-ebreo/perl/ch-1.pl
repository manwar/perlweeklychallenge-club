#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

#kth Permutation Sequence
#https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/

my @r;
my $n = $ARGV[0] || 3;
my $k = $ARGV[1] || 4;

#Definitely not optimized, can only easily handle $n = 9, larger n should work too but would take some time 
sub generate {
    my ($A,$k) = @_;
    if ($k == 1) {
        push @r, join "", @{$A};
    } else {
        
        for my $i (0..$k-1) {
            generate(\@{$A},$k-1);
            
            if ($i <= $k ) {
                my $h = $A->[$k-1];
                my $j = $k % 2 ? 0: $i;
                
                #swap values
                ($A->[$j],$A->[$k-1]) = ($A->[$k-1],$A->[$j]);
            }
        }
    }
}

my @x = 1..$n;
generate(\@x,$n);
@r = sort @r;
say $r[$k-1];

=begin
perl .\ch-1.pl      
231

perl .\ch-1.pl 7 2653
4615237

perl .\ch-1.pl 8 29805
68327415

perl .\ch-1.pl 9 345
123695748
=cut
