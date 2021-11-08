#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sorted list of unique positive integers.
Write a script to return list of arrays where the sub-arrays are consecutive integers.
=cut










sub _num2arr # ch.128, modified.
{
     my @numbers = sort { $a <=> $b} @_;
     my @output;
     my $previous = $numbers[0];
     my $from = my $to = $previous;
     my $last = $from;


     for my $num ( @numbers[1 .. $#numbers] )
     {
          if ( 1 >= ($num - $previous) )
          {
               $previous = $num;
          }
          else
          {


               my $to = $previous;
               push @output, [$from .. $last];
               $previous = $num;
               $from = $to = $previous;
          }
          $last = $num;
     }
     push @output, [$from .. $last];

     return @output;
}


print '[' . join('], [',  map join(", ", @$_), _num2arr(1, 2, 3, 6, 7, 8, 9)) . ']', $/;
print '[' . join('], [',  map join(", ", @$_), _num2arr(2, 4, 6, 8, 10)) . ']', $/;

print '[' . join('], [',  map join(", ", @$_), _num2arr(11, 12, 14, 17, 18, 19)) . ']', $/;
print '[' . join('], [',  map join(", ", @$_), _num2arr(1, 2, 3, 4, 5)) . ']', $/;