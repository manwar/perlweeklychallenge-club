#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a set of sorted non-overlapping intervals and a new interval. Write a script to merge the new interval to the given set of intervals.
Example 1: Input $S = (1,4), (8,10); $N = (2,6) Output: (1,6), (8,10)
Example 2: Input $S = (1,2), (3,7), (8,10); $N = (5,8) Output: (1,2), (3,10)
Example 3: Input $S = (1,5), (7,9); $N = (10,11) Output: (1,5), (7,9), (10,11)
=cut








use Bit::Vector;
use List::Util qw(max);
use Test::More;

sub insert_interval
{
     my @intervals = @_;

     @intervals = sort { $a->[0] <=> $b->[0] } @intervals;
     my $max = max(map @$_, @intervals);
     
     my @veclist = Bit::Vector->new($max + 1, scalar @intervals);
     $veclist[$_]->Interval_Fill(@{$intervals[$_]}) for 0 .. $#veclist;
     
     my @results;
     my $res = $veclist[0]->Shadow();
     

     for my $v ( @veclist )
     {


          if ($res->is_empty())
          {
               $res->Or($res, $v);
          }
          else
          {
               if ( $v->Min() <= $res->Max() ) 
               {

                    $res->Or($res, $v);
               }
               else
               {
                    my $res_p = $res->Clone();
                    push @results, [$res_p->Min(), $res_p->Max()];
                    $res->Empty();
                    $res->Or($res, $v);

               }
          }

     }
     push @results, [$res->Min(), $res->Max()];


     return @results;

}


is_deeply([insert_interval([1,4], [8,10], [2,6])], [[1, 6], [8, 10]], 'Example 1');
is_deeply([insert_interval([1,2], [3,7], [8,10], [5,8])], [[1, 2], [3, 10]], 'Example 2');
is_deeply([insert_interval([1,5], [7,9], [10,11])], [[1,5], [7,9],[10,11]], 'Example 3');

done_testing();