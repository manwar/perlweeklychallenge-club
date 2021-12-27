#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       semipro-prime.pl
#
#       method:
#           The semiprimes are interesting numbers
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $max = 100;

my @primes = make_prime_list( $max )->@*;
my %semis;

PRIME: for my $p ( @primes ) {
    for my $q ( grep { $_ >= $p } @primes ) {
        next PRIME if ($p * $q) > $max;
        $semis{ $p * $q }++;
    }
}

my @semiprimes = sort { $a <=> $b } keys %semis;

say $_ for @semiprimes;




sub make_prime_list ($max) {
## creates a list of all primes less than or equal to a given number
    my @primes = (2);
    CANDIDATE: for(  my $candidate = 3;  $candidate <= $max;  $candidate += 2  ) {
        my $sqrt_candidate = sqrt( $candidate );
        for(  my $test = 3; $test <= $sqrt_candidate; $test += 2  ) {
            next CANDIDATE if $candidate % $test == 0;
        }
        push @primes, $candidate;
    }
    return \@primes;
}














# use Test::More;
# 
# is 
# 
# done_testing();
