#1perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate first 50 members of FUSC Sequence. The sequence defined as below:
fusc(0) = 0 fusc(1) = 1
for n > 1:
when n is even: fusc(n) = fusc(n / 2),
when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
=cut





sub generate_fusc
{
     my $max = $_[0];
     my @arr;
     my $i = - 1; 

     return sub
     {
          $i++; 

          if     ( $i < 2 ) { $arr[$i] = $i; }
          elsif  ( $i % 2 ) { $arr[$i] = $arr[($i-1)/2] + $arr[($i+1)/2]; }
          else              { $arr[$i] = $arr[$i / 2]; }
          return undef if $i > $max;
          return [$i, $arr[$i]];
     }
}

my $next = generate_fusc(50);
while ( my $item = $next->() ) { print join(": ", @$item), $/; }