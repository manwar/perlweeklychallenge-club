#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

use strict; use warnings;

my($m, $n) = @ARGV;
print "@$_\n" for pp($m, $n);

sub pp {  #prime partitions without duplicates, pure perl version
    my($m, $n, $pp, @p) = @_;
    $pp //= [];
    $n ? map pp( $m-$_, $n-1, $pp, @p, $_),
	 grep is_prime($_),
	 1+($p[-1]//1) .. $m
       : $m==0 && push @$pp, \@p;
    @$pp;
}
sub is_prime { local $_ = 1 x (shift//$_); !/^1?$|^(11+?)\1+$/ }

__END__

Example 1:

perl ch-1.pl 73 3   #run with m=73 and n=3 to get the list of the 17
                    #three part unique prime partitions that adds to 73
Output:

3 11 59
3 17 53
3 23 47
3 29 41
5 7 61
5 31 37
7 13 53
7 19 47
7 23 43
7 29 37
11 19 43
13 17 43
13 19 41
13 23 37
13 29 31
17 19 37
19 23 31

Example 2:

perl ch-1.pl 37 4
2 3 13 19
2 5 7 23
2 5 11 19
2 5 13 17
2 7 11 17

Example 3, larger numbers:

time perl ch-1.pl 1001 3        | wc -l     # 1061 lines in 34 seconds
time perl ch-1-faster.pl 1001 3 | wc -l     # 1061 lines in 0.035 seconds, 1000 times faster
