#!perl
use strict;
use warnings FATAL => qw(all);

=notes
As said I tried the pigeonhole algorithmus seen here (posted by N.S.): https://math.stackexchange.com/questions/83932. 
It does produce the multiples, even very quickly for such tough cases as 999 and 1998. However it does not necessary produce the _smallest_ multiple, especially for the smaller numbers.
Here is another implementation using algorithmus posted by ShreevatsaR at https://math.stackexchange.com/questions/388165. For some numbers with the very long small multiples it is still prohibitely slow however (at least with my implementation). Some runs s. below.
Probably the most promising would be the method described by algorithmshark at https://math.stackexchange.com/questions/164986, however I was not able to implement it.
=cut 



use List::Util qw(reduce);
use bigint;
use Time::HiRes qw[ time ];

my $start = time;
my $NUM = shift or die "Which number?$/";
my %rem;

POW: for my $pow ( 0 .. $NUM + 1 ) # (0 .. 30) is not faster.
{
     my $mod = (10 ** $pow) % $NUM;

     $rem{$pow} = $mod;

     for my $k ( sort keys %rem )
     {
          if ( $k ne $pow )
          {
               $rem{"${k}+${pow}"} = $rem{$k} + $mod;
          }
     }


     for my $k ( sort keys %rem )
     {


          if ( 0 == $rem{$k} % $NUM )
          {
               my @powers = split(/\+/,$k);

               my $result = reduce { $a + $b } map { 10 ** $_ } @powers;
               print $result, $/;
               last POW;
          }

     }
}
print "Used time: ", time() - $start, $/;






=output
>perl ch-1a.pl 99
111111111111111111
Used time: 10.8549320697784

>perl ch-1a.pl 198
1111111111111111110
Used time: 29.7949650287628

>perl ch-1a.pl 792
111111111111111111000
Used time: 155.41130900383
=cut