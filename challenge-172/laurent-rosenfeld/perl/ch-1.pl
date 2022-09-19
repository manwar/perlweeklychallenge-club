use strict;
use warnings;
use feature "say";

my @primes = grep { is_prime($_) } 1..100;
my %seen;

sub is_prime {
   my $n = shift;
   return 1 if $n == 2;
   return 0 if $n % 2 == 0;
   return 0 if $n == 1;
   my $p = 3;
   my $sqrt = sqrt $n;
   while ($p <= $sqrt) {
       return 0 if $n % $p == 0;
       $p += 2;
   }
   return 1;
}

sub partition  {
    my ($m, $n) = @_;
    return if $n < 2;
    if ($n == 2) {
        for my $i (@primes) {
            last if $i >= $m;
            my $j = $m - $i;
            next if $j == $i;
            next if $seen{$i} or $seen{$j};
            return $i, $j if is_prime($j);
        }
        return;
    } else {
        for my $i (@primes) {
            last if $i >= $m;
            %seen = ($i => 1);
            my @sub_partition = partition($m - $i, $n-1);
            next if @sub_partition < 2;
            return ($i, @sub_partition);
        }
        return;
    }
}
for my $test ([18, 2], [19, 3], [17, 3], [25, 2]) {
    my @partition = partition(@$test);
    say @partition < 2 ? "@$test: No solution" : "Solution for @$test: @partition";
}
