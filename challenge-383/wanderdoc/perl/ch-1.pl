#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three list of strings.
Write a script to find out if the first two list are similar with the help the third list. The third list contains the similar words map.
Example 1
Input: $list1 = ("great", "acting")
       $list2 = ("fine", "drama")
       $list3 = (["great", "fine"], ["acting", "drama"])
Output: true

Example 2

Input: $list1 = ("apple", "pie")
       $list2 = ("banana", "pie")
       $list3 = (["apple", "peach"], ["peach", "banana"])
Output: false

Example 3

Input: $list1 = ("perl4", "python")
       $list2 = ("raku", "python")
       $list3 = (["perl4", "perl5", "raku"])
Output: true

Example 4

Input: $list1 = ("enjoy", "challenge")
       $list2 = ("love", "weekly", "challenge")
       $list3 = (["enjoy", "love"])
Output: false

Example 5

Input: $list1 = ("fast", "car")
       $list2 = ("quick", "vehicle")
       $list3 = (["quick", "fast"], ["vehicle", "car"])
Output: true

=cut


use constant {true => 1, false => 0};
use Test2::V0 -no_srand => 1;



is(similar_lists(["great", "acting"], ["fine", "drama"], [["great", "fine"], ["acting", "drama"]]), true, 'Example 1');
is(similar_lists(["apple", "pie"], ["banana", "pie"], [["apple", "peach"], ["peach", "banana"]]), false, 'Example 2');
is(similar_lists(["perl4", "python"], ["raku", "python"], ["perl4", "perl5", "raku"]), true, 'Example 3');     
is(similar_lists(["enjoy", "challenge"], ["love", "weekly", "challenge"], ["enjoy", "love"]), false, 'Example 4');
is(similar_lists(["fast", "car"], ["quick", "vehicle"], [["quick", "fast"], ["vehicle", "car"]]), true, 'Example 5');
done_testing();



sub similar_lists
{
     my ($list1, $list2, $list3) = @_;
     return false if scalar @$list1 != scalar @$list2;
     my %dict;
     
     if ( ref $list3->[0] eq 'ARRAY') # $list3 is AoA
     {
          for my $chunk ( @{$list3} )
          {
               my $replace = join('|', @{$chunk}[1 .. $#$chunk]);
               $dict{$chunk->[0]} = $replace;
          }
     }
     else # $list 3 is an aref
     {
          my $replace = join('|', @{$list3}[1 .. $#$list3]);
          $dict{$list3->[0]} = $replace;
     }
     for my $idx ( 0 .. $#$list1 )
     {
          if ( $list1->[$idx] ne $list2->[$idx] and
               (not exists $dict{$list2->[$idx]} 
                    or $list1->[$idx] !~ /$dict{$list2->[$idx]}/) and
               (not exists $dict{$list1->[$idx]} 
                    or $list2->[$idx] !~ /$dict{$list1->[$idx]}/)
               )
          {
               return false;
          }
     }
     return true;
}
