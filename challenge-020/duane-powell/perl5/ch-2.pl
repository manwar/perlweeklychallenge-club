#!/usr/bin/perl
use Modern::Perl;
use ntheory qw(divisors);

# Write a script to print the smallest pair of Amicable Numbers. For more information,
# please checkout wikipedia https://en.wikipedia.org/wiki/Amicable_numbers
# The first ten amicable pairs are:
# (220, 284), (1184, 1210), (2620, 2924), (5020, 5564), (6232, 6368), (10744, 10856),
# (12285, 14595), (17296, 18416), (63020, 76084), and (66928, 66992)

my $limit = shift || 76084;

# iterate over all numbers up to limit and sum their divisors
my %n; # hash of divisors sums, for example, $n{10} = 8 = 1+2+5
my $n = 1;
while ($n <= $limit) {
    my @d = divisors($n);
    pop(@d); #discard self, for example the divisors of 10 are 1,2,5,10, so discard 10

    map { $n{$n} += $_ } @d;
    $n++;
}

# search our hash for pairs, $p
foreach my $n (sort {$a <=> $b} (keys %n)) {
    my $p = $n{$n};
    if ( exists($n{$p}) ) {
    	say "($n, $n{$n})" if ($n{$p} == $n and $p != $n);
    	delete $n{$n}; # so we don't match twice
    }
}

__END__

./ch-2.pl
(220, 284)
(1184, 1210)
(2620, 2924)
(5020, 5564)
(6232, 6368)
(10744, 10856)
(12285, 14595)
(17296, 18416)
(63020, 76084)
(66928, 66992)
(67095, 71145)

./ch-2.pl 1000000
(220, 284)
(1184, 1210)
(2620, 2924)
(5020, 5564)
(6232, 6368)
(10744, 10856)
(12285, 14595)
(17296, 18416)
(63020, 76084)
(66928, 66992)
(67095, 71145)
(69615, 87633)
(79750, 88730)
(100485, 124155)
(122265, 139815)
(122368, 123152)
(141664, 153176)
(142310, 168730)
(171856, 176336)
(176272, 180848)
(185368, 203432)
(196724, 202444)
(280540, 365084)
(308620, 389924)
(319550, 430402)
(356408, 399592)
(437456, 455344)
(469028, 486178)
(503056, 514736)
(522405, 525915)
(600392, 669688)
(609928, 686072)
(624184, 691256)
(635624, 712216)
(643336, 652664)
(667964, 783556)
(726104, 796696)
(802725, 863835)
(879712, 901424)
(898216, 980984)

