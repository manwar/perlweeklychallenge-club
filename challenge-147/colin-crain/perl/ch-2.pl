#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Pentagon Numbers
#         Submitted by: Mohammad S Anwar
#         Write a sript to find the first pair of Pentagon Numbers whose
#         sum and difference are also a Pentagon Number.
# 
#         Pentagon numbers can be defined as P(n) = n(3n - 1)/2.
# 
#         Example
#         The first 10 Pentagon Numbers are:
#         1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.
# 
#         P(4) + P(7) = 22 + 70 = 92 = P(8)
#         but
#         P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.
# 
#       method:
# 
#         Shooting from the hip, I saw this as a math problem: we have
#         three variables, that fit into two equations. It's a fairly
#         simple system of linear equations that should be solvable without
#         going crazy.
# 
#         But then again it's not a math problem, its a programming
#         problem. It's both, really, but sometimes things can be two
#         things at once. Trust me, I know: I had a girlfriend like that
#         once a long time ago, and I learned this lesson the hard way.
# 
#         But I digress.
# 
#         It's a little unclear what we mean my "first pair" in this
#         multidimensional context. I can think of a couple of criteria:
#         the lowest first value? Combined value? Summed? Multiplied?
# 
#         Although not stated in the description if we conclude that the
#         pentogonal numbers are a the next extension of square numbers and
#         triangular numbers before those, then the pentagonals describe a
#         cardinal quantity, and as such are positive or zero. And we
#         probably exclude zero.
# 
#         This is indeed the case, and we should add `n ≥ 1` to the above
#         description.
# 
#         From the quadratic definition we can next see that the
#         pentagonals will always be increasing, P(n+1) > P(n) ∀ n ≥ 1
# 
#         So from this we can require that for two values n and m, such
#         that
# 
#             P(n) - P(m) = P(t)
# 
#         for some t, then m must be less than n.
# 
#         We'll start with the tuple
# 
#             (n,m) = (2,1)
# 
#         and start working upwards from there, incrementing n by 1 and
#         then searching m for all values 1 to n-1.
# 
#         This searches the data space in a regular, expanding pattern that
#         should satisfy some definitions of "first".
# 
#         It's brutal but should be effective. We'll quit when we find one
#         or stop the process because we're tired of waiting.
# 
#       Report:
#       
#         If finds the solution, n = 2167, m = 1020, in short order:
#         
#             found pair n = 2167, m = 1020 :
# 
#             P(2167) = 7042750
#             P(1020) = 1560090
#             sum is 8602840
#                 which is P(2395)
#             diff is 5482660
#                 which is P(1912) 
# 
#         
#         
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my %penta   = map { $_ => pentagons($_) } (1..1000000 );
my %lookup  = reverse %penta;
my ($n, $m) = (1,0);

OUTER: while ( $n++ ) {
    $m = 0;
    while ( ++$m < $n ) {
        last OUTER if exists $lookup{ $penta{$n} + $penta{$m} } and
            exists $lookup{ $penta{$n} - $penta{$m} } ;
    }
}

sub pentagons ( $n ) {
    return $n * ( 3 * $n - 1 ) / 2
}

## output report

my $sum  = $penta{$n} + $penta{$m};
my $diff = $penta{$n} - $penta{$m};

say <<~"END";
    found pair n = $n, m = $m :

    P($n) = $penta{$n}
    P($m) = $penta{$m}
    sum is $sum
        which is P($lookup{$sum})
    diff is $diff
        which is P($lookup{$diff}) 
    END


