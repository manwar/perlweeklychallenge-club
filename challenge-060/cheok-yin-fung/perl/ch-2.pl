#!/usr/bin/perl
use strict;
use List::MoreUtils qw(uniq);
use Math::Combinatorics;

my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;

my @freq;
my @modifiedL = uniq @L;
for (0..$#L) {
    if ($_ != 0) {
        $freq[$_] = $X/length($modifiedL[$_]) ;
    }
    else {
        $freq[$_] = $X;
    }

}


my @combo = ();
my @unique_n = ();

for (1..$X) {
    my $A = Math::Combinatorics->new(
             count=>$_, 
             data => [@modifiedL], 
             frequency => [@freq] );
    while (my @candidates = $A->next_multiset) {
        my $candidate = join "", @candidates;
        my $C = Math::Combinatorics->new(
                 count=>length($candidate),
                 data => [@candidates]);
       while (my @Bl = $C->next_permutation) {
            my $B = join "", @Bl;
            $B = $B+0;
            if (length($B)==$X) {
                if ($B < $Y and 0 < $B) {
                    push @combo, $B;
                }
            }
        }
    }
}

@unique_n = uniq @combo;
print join " ," , sort @unique_n;
print "\n";
