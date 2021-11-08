#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a score $S. You can win basketball points e.g. 1 point, 2 points and 3 points.
Write a script to find out the different ways you can score $S.
=cut








use Math::Combinatorics;
use Algorithm::Combinatorics qw (subsets);
use List::MoreUtils qw(first_index);

use Time::HiRes qw(time);

my %SEEN;

scores(shift);

sub scores
{
     my $num = $_[0] or die "How many points?$/"; 
     my $start = time;
     for my $point_set (subsets([3, 2, 1]))
     {
          my @points = @$point_set;
          my @output;

          my $rest = $num;
          for my $i ( 0 .. $#points )
          {


               while ( $points[$i] <= $rest )
               {
                    push @output, $points[$i];

                    $rest -= $points[$i];
               }
          }
          next if $rest;

          multiset_permutations(@output);

          my @output_2 = @output;
          while ( (first_index { $_ == 3 } @output) != -1 )
          {
               my $idx = first_index { $_ == 3 } @output;
               splice(@output, $idx,1);
               push @output, (2, 1);

               multiset_permutations(@output);
          }

          while ( (first_index { $_ == 2 } @output_2) != -1 )
          {
               my $idx = first_index { $_ == 2 } @output_2;
               splice(@output_2, $idx,1);
               push @output_2, (1, 1);

               multiset_permutations(@output_2);
          }


          while ( (first_index { $_ == 2 } @output) != -1 )
          {

               my $idx = first_index { $_ == 2 } @output;

               splice(@output, $idx,1);
               push @output, (1, 1);

               multiset_permutations(@output);
          }

     }
     printf STDERR "Took %f seconds\n", time() - $start;

}

sub multiset_permutations
{
     my @arr = @_; 
     return if exists $SEEN{join(" ", sort {$a <=> $b} @arr)};  
     $SEEN{join(" ", sort {$a <=> $b} @arr)} = undef;


     my %freq;
     $freq{$_}++ for @arr;
     print "@arr$/" and return 
          if ( exists $freq{1} and $freq{1} == scalar @arr);
     my $o = Math::Combinatorics->new( 
                    count=> scalar @arr , 
                    data=>[sort {$a <=> $b} keys %freq] , 
                    frequency=>[@freq{sort {$a <=> $b} keys %freq}] );


     while ( my @x = $o->next_multiset ) 
     {
          my $p = Math::Combinatorics->new( 
                    data=>\@x, 
                    frequency=>[map{1} @x] );
          while ( my @y = $p->next_string )
          {
               print "@y$/";

          }
     }
}