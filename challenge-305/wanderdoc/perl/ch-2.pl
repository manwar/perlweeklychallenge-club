#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the alien dictionary characters.
Example 1

Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")

Example 2

Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
=cut

use Test2::V0 -no_srand => 1;

is(custom_sort(["perl", "python", "raku"], [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]), ["raku", "python", "perl"], 'Example 1');
is(custom_sort(["the", "weekly", "challenge"], [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]), ["challenge", "the", "weekly"], 'Example 2');
done_testing();

sub custom_sort
{
     my ($words_aref, $letters_aref) = @_;
     my $counter = 0;
     my %points = map {$_ => $counter++} @$letters_aref;
     
     @$words_aref = sort 
     {
          my @left  = split(//, $a);
          my @right = split(//, $b);
          my $max_len = length($a) > length($b) ? length($a) : length($b);
          my $max_idx = $max_len - 1;
          for my $idx ( 0 .. $max_idx )
          {
               return -1 if not defined $left[$idx];
               return  1 if not defined $right[$idx];
               next if $left[$idx] eq $right[$idx];
               return $points{$left[$idx]} <=> $points{$right[$idx]};
          }
     }
     @$words_aref;
     return $words_aref;
}