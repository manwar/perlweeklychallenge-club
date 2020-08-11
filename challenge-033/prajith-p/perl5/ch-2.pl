#!/usr/bin/perl

use feature qw<say>;

my $start = 1;
my $end   = shift // 11;

sub head { 
    printf('%4s', shift) 
}

printf("%2s|", 'x');
head($_) for ($start .. $end);
printf "\n%2s%3s\n", "-+", "-"  x (($end * 4) + 4);

for my $n ($start..$end) {
   printf "%2s|", $n;
   for my $x ($start..$end) {
       printf " %3s", ( $x >= $n ) ? $x*$n : ' ';
   }
   print "\n";
}
