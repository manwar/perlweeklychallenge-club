#!/usr/bin/env perl
=bein pod
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-12-05
Challenge 246 6 Out of 49  ( Perl )
-------------------------------------
=cut

use v5.38;

my %seen = ();
my @sorted = ();
my @unsorted = ();

my $cnt = 0;
while(1) {
    my $num = int(rand(100));
    next if exists($seen{$num});
    $seen{$num} = 1;
    if ($num > 0 and $num <= 49) {
        push(@unsorted,$num);
        $cnt++;
        last if $cnt == 6;
    }
}
@sorted = sort { $a <=> $b } @unsorted;
say "@sorted";

#-------------------------------------
#SAMPLE OUTPUT
#perl Sixoutof49.pl

# 3 8 17 23 30 31
#-------------------------------------


