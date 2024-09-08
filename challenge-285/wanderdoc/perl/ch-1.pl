#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of routes, @routes.

Write a script to find the destination with no further outgoing connection.
Example 1

Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"

"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".

Example 2

Input: @routes = (["A","Z"])
Output: "Z"

=cut


use Test2::V0;
use List::Util qw(uniq);

is(construction(["B","C"], ["D","B"], ["C","A"]), 'A', 'Example 1');
is(construction(["A","Z"]), 'Z', 'Example 2');
is(logic(["B","C"], ["D","B"], ["C","A"]), 'A', 'Example 1A');
is(logic(["A","Z"]), 'Z', 'Example 2A');
done_testing();

sub construction
{
     my @arr = @_;
     if ( 1 == scalar @arr )
     {
          return $arr[0]->[1];
     }
     my @paths;
     for my $idx_1 ( 0 .. $#arr )
     {
          my @step = @{$arr[$idx_1]}; 
          for my $idx_2 ( 0 .. $#arr )
          {
               next if ( $idx_1 == $idx_2 );
               

               if ( $arr[$idx_2]->[0] eq $step[-1])
               {
                    push @step, @{$arr[$idx_2]}
               }
          }
          my $step_str = join('', @step);
          $step_str =~ s/(?<char>.)\k<char>/$1/g; 
          push @paths, $step_str;
     }
     my @output = uniq map substr($_, -1, 1), @paths;
     return wantarray ? @output : "@output";
}

sub logic
{
     my @arr = @_;
     my %first = map {$_->[0] => undef} @arr;
     my %last  = map {$_->[1] => undef} @arr;
     delete @last{keys %first};
     return wantarray ? keys %last : join('', keys %last);
}