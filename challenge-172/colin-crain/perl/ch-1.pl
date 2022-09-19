#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       partings-in-the-prime-of-life.pl
#
#       Prime Partition
#         Submitted by: Mohammad S Anwar
#         You are given two positive integers, $m and $n.
# 
#         Write a script to find out the Prime Partition of the given number.
#         No duplicates allowed.
# 
#         For example,
# 
#             Input: $m = 18, $n = 2
#             Output: 5, 13 or 7, 11
#     
#             Input: $m = 19, $n = 3
#             Output: 3, 5, 11

#         method:
# 
#         A decidedly non trivial problem for a first task this week!
# 
#         Prime partitioning is a decidely complex math problem, and it
#         seems the only easily-managed, albeit computationallyexpensive
#         solution is to investigate all patterns of or the list of primes
#         smaller than the target number to see whether they can be summed
#         to resolve correctly.
# 
#         As the resulting lists will be of largely-unknownn and of variable
#         lengths, a recursive solution is warranted. A prime is
#         added to a partial list, a partial sum is accumulated, and then
#         the partial pattern and sum are handed to the routine again, this
#         time searching for a new target properly reduced by the prime
#         that was added.
# 

#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use List::Util qw( sum0 );

my  $target = shift @ARGV // 19;

our @parts;
my  @prime_list = sieve( $target );

pparts( $target, 0, \@prime_list, [] );

say "$_->@*" for @parts;


## subs

sub pparts( $target, $sum, $primes, $try ) {
## recursive partions using only prime values from given list
## alters global @parts array to record results
    push @parts, $try and return if $sum == $target;
    return                       if $primes->@* == 0; 
    
    for my $p ( $primes->@* ) {
        my $new_sum     = $sum + $p;
        my @new_primes  = grep { 
                              $p < $_ && $new_sum + $_ <= $target 
                          } $primes->@*;
        pparts( $target, $new_sum, \@new_primes, [$try->@*, $p]);
    }
}

sub sieve ($limit) {
##  sieve of Eratosthenes
    my @s = (1) x $limit;
    @s[0,1] = (0,0);    
    for my $f (2..sqrt($limit)) {    
        $s[$f * $_] = 0 for $f..$limit/$f;
    }
    return grep { $s[$_] } (0..$limit);
}

