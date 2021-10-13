# The Weekly Challenge 134
# Task 1 Pandigital Numbers
# Usage: ch-1.pl [numbers of pandigital numbers]
use v5.12;
use warnings;
use Test::More tests => 2;
use Test::Deep;
use Algorithm::Combinatorics qw(permutations);

my $terms = $ARGV[0] || 5;

my @arr = (1,0,2,3,4,5,6,7,8,9);

my @factorial = (1, 1, 2, 6, 24, 120, 720, 5040, 40320);

die "Sorry, I am lazy. Aren't you asking too much?\n"
    if $terms > $factorial[8];

say join "\n", run($terms)->@*;



sub run {
    my $t = $_[0];
    my $ind = 0;
    do $ind++ while $t > $factorial[$ind];

    my @all_perm = permutations([ @arr[10-$ind..9] ]);
    @all_perm = map { join "", @arr[0..9-$ind], @{$_}} @all_perm;
    my @ans = @all_perm[0..$t-1];
    # @ans = sort {$a<=>$b} @ans;
    return [@ans];
}



cmp_deeply run(5), 
    [1023456789, 1023456798, 1023456879, 
     1023456897, 1023456978], "task requirement";

cmp_deeply run(21), 
    [1023456789, 1023456798, 1023456879, 1023456897, 
     1023456978, 1023456987, 1023457689, 1023457698, 
     1023457869, 1023457896, 1023457968, 1023457986, 
     1023458679, 1023458697, 1023458769, 1023458796, 
     1023458967, 1023458976, 1023459678, 1023459687, 
     1023459768], "OEIS showcase";
