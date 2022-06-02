use warnings;
use feature "say";
use constant MAX => 10;

my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31); #Init small primes

sub is_prime {
   my $n = shift;
   for my $p (@primes) {
       return 1 if $p >= $n;
       return 0 if $n % $p == 0;
   }
   return 1;
}

sub rotate_and_test {
    my $i = shift;
    my $nb = length $i - 1;
    for (1..$nb) {
        $i = substr($i, 1) . substr($i, 0, 1);
        return 0 unless is_prime $i;
        $seen{$i} = 1;
    }
    return 1;
}

my $max = 10;
my $count = 0;
my $n = 99;
while (1) {
    $n += 2;
    next unless is_prime $n;
    next if $seen{$n};
    next unless rotate_and_test $n;
    print "$n ";
    $count++;
    last if $count >= MAX;
}
