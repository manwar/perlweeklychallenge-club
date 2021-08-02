#!/usr/bin/env perl

# Prints the Nth ugly number given by the first command line argument.
# An ugly number is an integer factorized only by 2, 3 and 5s and no
# other primes where 1 is considered the first ugly number.
#
# sub is_ugly return 1 (true) for ugly integers and 0 (false) otherwise.
# sub nth_ugly returns the Nth ugly number by recursion.
#
# Linux command line test:
# for n in {1..30}; do echo -n "$n  "; perl ch-1.pl $n; done
# Outputs the first 30 which is:
# 1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50 54 60 64 72 75 80

sub is_ugly {
    my $n=shift;
    $n != int$n                   ? 0
   :$n == 1                       ? 1
   :( grep is_ugly($n/$_),2,3,5 ) ? 1
   :                                0
}

sub nth_ugly {
    my($n,$try)=(@_,0);
    $n ? nth_ugly( $n - is_ugly(++$try), $try) : $try
}

my($N)=@ARGV;

print nth_ugly( $N ), "\n";
