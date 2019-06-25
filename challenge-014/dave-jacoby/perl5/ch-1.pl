#!/usr/bin/env perl

use strict ;
use warnings ;
use feature qw{ postderef say signatures state } ;
no warnings qw{ experimental::postderef experimental::signatures } ;

use Carp;

# Write a script to generate Van Eck’s sequence starts with 0. 
# For more information, please check out wikipedia page. 
# This challenge was proposed by team member Andrezgz.


# 0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5 ... [1]

# let a[0] = 0 
my @a ;
push @a , 0;

for my $n ( 0 .. 30 ) {

    # otherwise a[n+1]=0
    $a[$n+1] = 0;
    
    # for n >= 0, if there exists an m < n such that a[m] == a[n],
    # take the largest such m and set a[n+1] = n-m, 
    for my $m ( 0 .. $n -1 ) {
        $a[$n+1] = $n - $m if $a[$n]==$a[$m];
    }
    say qq{n = $n \t a[n] = $a[$n]};
}

__DATA__

n = 0 	 a[n] = 0
n = 1 	 a[n] = 0
n = 2 	 a[n] = 1
n = 3 	 a[n] = 0
n = 4 	 a[n] = 2
n = 5 	 a[n] = 0
n = 6 	 a[n] = 2
n = 7 	 a[n] = 2
n = 8 	 a[n] = 1
n = 9 	 a[n] = 6
n = 10 	 a[n] = 0
n = 11 	 a[n] = 5
n = 12 	 a[n] = 0
n = 13 	 a[n] = 2
n = 14 	 a[n] = 6
n = 15 	 a[n] = 5
n = 16 	 a[n] = 4
n = 17 	 a[n] = 0
n = 18 	 a[n] = 5
n = 19 	 a[n] = 3
n = 20 	 a[n] = 0
n = 21 	 a[n] = 3
n = 22 	 a[n] = 2
n = 23 	 a[n] = 9
n = 24 	 a[n] = 0
n = 25 	 a[n] = 4
n = 26 	 a[n] = 9
n = 27 	 a[n] = 3
n = 28 	 a[n] = 6
n = 29 	 a[n] = 14
n = 30 	 a[n] = 0
