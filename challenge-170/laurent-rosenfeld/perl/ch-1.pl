use strict;
use warnings;
use feature "say";


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

my ($i, $count, $product) = (1, 0, 1);
my @result;
while (1) {
    $i++;
    next unless is_prime $i;
    $count++;
    $product = $product * $i;
    push @result, $product;
    last if $count >= 10;
}
say "@result";
