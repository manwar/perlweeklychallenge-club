# Perl Weekly Challenge #076 Task 1 Prime Sum
# task statement:
# You are given a number $N. Write a script 
# to find the minimum number of prime numbers 
# required, whose summation gives you $N.
# Usage: ch-1.pl $N

# Given the Goldbach's conjecture is verified 
# for n < 4 000 000 000 000 000 000 
# ( source: mathworld.wolfram.com )

use strict;
use warnings;

sub is_prime {
    my $ans = 1; 
    for my $i (2..int sqrt($_[0])) {
        if ($_[0] % $i == 0) {$ans = 0; return 0;} 
    } 
    return $ans; 
}

my %oddprime;
my $V;
if ($ARGV[0]) {$V = $ARGV[0];} else {$V = 1024;}

# small special cases

if ($V == 1) {
    print "0\nas 1 is smaller than the smallest prime.\n";
    exit;
}

if ($V == 2) {
    print "1\nas 2 is the smallest prime.\n";
    exit;
}

if ($V == 4) {
    print "2\nas 2 + 2 = 4 and 4 is not a prime.\n";
    exit;
}

# normal cases
sub setoddprime {
    for my $p (3..$V) {$oddprime{$p} = 1 if is_prime($p);}
}


if ($V % 2 == 0) {
    print "2\n";
    setoddprime;
    for (keys %oddprime) {
        if ($oddprime{$V-$_}) {
            print "as $_", " + ", $V-$_," = $V.\n" ;
            last;
        }
    }
} 
else {
    setoddprime;
    if ($oddprime{$V}) {
        print "1\nas $V is a prime.\n";
    } 
    elsif ($oddprime{$V-2}) {
            print "2\nas 2 + " ,$V-2, " = $V\nand $V is not a prime.\n" ,
        }
        else {
            print "3\n";
            for (keys %oddprime) {
                if ($oddprime{$V-3-$_}) {
                    print "3 + $_", " + ", $V-$_-3," = $V .\n";
                    print "The answer can't be 1 or 2 because",
                          " neither ", $V-2 ," nor $V is a prime; and\n", 
                          " there are no even primes except 2\n",
                          " (two odd primes sum to an even number).\n";
                    last;
                }
            }
        }
}

