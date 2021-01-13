#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate a list of 20 random integers between 1 and 50. It should then find an integer, say N, in the list so that there are exactly N number of integers greater than N. If you can't find the number print -1 otherwise 1.
For example,
Suppose we have list of 4 integers [2, 6, 1, 3].
Here we have 2 in the above list, known as Noble Integer, since there are exactly 2 integers in the list i.e.3 and 6, which are greater than 2.
Therefore the script would print 1.
=cut


use List::Util qw(sample);

my $MIN = 1;
my $MAX = 50;
my $SAMPLE = 20;

my @range = ($MIN .. $MAX);
noble(\@range, $SAMPLE) for 1 .. 20;

sub noble
{
     my ($aref, $n) = @_;

     my @list = sort {$a <=> $b} sample($n, @$aref);
     for my $int ( @list )
     {
          my $count = grep $_ > $int, @list;
          if ( $int == $count )
          {
               print "1$/"; # "1: $int $count$/";
               return;
          }
     }
     print "-1$/";
}