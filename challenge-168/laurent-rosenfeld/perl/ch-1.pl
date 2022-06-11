use strict;
use warnings;
use feature "say";

my @perrin = (3, 0, 2);
my @result = (2, 3);
my %seen = map { $_ => 1 } @result;
while (1) {
    my $new_item = $perrin[-3] + $perrin[-2];
    push @perrin, $new_item;
    if (is_prime($new_item)) {
        push @result, $new_item unless $seen{$new_item};
        $seen{$new_item} = 1;
        last if @result > 12;
    }
}
say join " ", sort { $a <=> $b } @result;

sub is_prime {
   my $n = shift;
   return 1 if $n == 2;
   return 0 if $n % 2 == 0;
   return 0 if $n == 1;

   my $p = 3;
   my $sqrt = sqrt $n;
   while ($p <= $sqrt) {
       # return 1 if $p >= $n;
       return 0 if $n % $p == 0;
       $p += 2;
   }
   return 1;
}
