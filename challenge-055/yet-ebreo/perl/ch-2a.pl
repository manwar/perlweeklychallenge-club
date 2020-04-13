#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Time::HiRes 'time';
use Math::Combinatorics;

my $start_time = time;
my @n = sort {$a - $b} @ARGV ? @ARGV : (1, 2, 3, 4) ;
my %h;

for my $elem (permute(@n)) {
    my $flag = 1;
    for my $e (1..$#{$elem}) {
        !($flag &= $e % 2? $elem->[$e]<=$elem->[$e-1] : $elem->[$e]>=$elem->[$e-1]) && last;   
    }
    #Only unique permutation will be printed
    $flag && !$h{"@{$elem}"}++ && say "@{$elem}"
}

my $elapsed = time - $start_time;
printf ("Execution Time: %.6f seconds",$elapsed);
=begin
perl .\ch-2a.pl
3 1 4 2
3 2 4 1
2 1 4 3
4 1 3 2
4 2 3 1
Execution Time: 0.000916 seconds

perl .\ch-2a.pl 1 2 2 3 4
2 1 4 2 3
2 1 3 2 4
2 2 4 1 3
2 2 3 1 4
4 1 2 2 3
4 1 3 2 2
4 2 2 1 3
4 2 3 1 2
3 1 2 2 4
3 1 4 2 2
3 2 2 1 4
3 2 4 1 2
Execution Time: 0.002716 seconds

perl .\ch-2a.pl 1 2 3 4 5 6 7 8 9
...
8 6 9 4 5 2 7 1 3
8 6 9 4 7 1 3 2 5
8 6 9 4 7 1 5 2 3
8 6 9 4 7 3 5 1 2
8 6 9 4 7 2 3 1 5
8 6 9 4 7 2 5 1 3
Execution Time: 20.922912 seconds

perl .\ch-2a.pl 1 2 3 4 5 6 7 8 9 10
...
10 8 9 6 7 2 5 1 4 3
10 8 9 6 7 2 5 3 4 1
10 8 9 6 7 2 4 1 5 3
10 8 9 6 7 2 4 3 5 1
10 8 9 6 7 4 5 1 3 2
10 8 9 6 7 4 5 2 3 1
Execution Time: 219.184307 seconds
=cut
