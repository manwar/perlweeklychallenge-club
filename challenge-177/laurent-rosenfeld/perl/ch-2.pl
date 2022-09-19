use strict;
use warnings;
use feature qw/say/;

sub is_cyclops {
    my $n = shift;
    my $len = length $n;
    return 0 if $len % 2 == 0;
    my $mid = ($len - 1) /2;
    return 0 if substr($n, $mid, 1) != 0;
    return 0 if (split //, $n)[0..$mid-1] =~ /0/;
    return 0 if (split //, $n)[$mid+1..$len-1] =~ /0/;
    return 1;
}

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

my $count = 0;
for my $i (100..999, 10000..99999, 1000000..9999999) {
    next unless $i eq reverse $i;
    next unless is_cyclops $i;
    if (is_prime $i) {
        print "$i ";
        $count++;
        last if $count == 20;
    }
}
