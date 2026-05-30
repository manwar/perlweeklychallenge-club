#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two array of strings.
Write a script to return the number of strings that appear exactly once in each of the two given arrays. String comparison is case sensitive.
Example 1

Input: @array1 = ("apple", "banana", "cherry")
       @array2 = ("banana", "cherry", "date")
Output: 2

Example 2
Input: @array1 = ("a", "ab", "abc")
       @array2 = ("a", "a", "ab", "abc")
Output: 2

"a" appears once in @array1 but appears twice in @array2, therefore, not counted.

Example 3

Input: @array1 = ("orange", "lemon")
       @array2 = ("grape", "melon")
Output: 0

Example 4
Input: @array1 = ("test", "test", "demo")
       @array2 = ("test", "demo", "demo")
Output: 0

Example 5
Input: @array1 = ("Hello", "world")
       @array2 = ("hello", "world")
Output: 1

String comparison is case sensitive.
=cut


use Test2::V0 -no_srand => 1;
is(single_common_word(["apple", "banana", "cherry"], 
     ["banana", "cherry", "date"]), 2, 'Example 1');
is(single_common_word(["a", "ab", "abc"], 
     ["a", "a", "ab", "abc"]), 2, 'Example 2');
is(single_common_word(["orange", "lemon"], 
     ["grape", "melon"]), 0, 'Example 3');
is(single_common_word(["test", "test", "demo"], 
     ["test", "demo", "demo"]), 0, 'Example 4');
is(single_common_word(["Hello", "world"], 
     ["hello", "world"]), 1, 'Example 5');

done_testing();



sub single_common_word
{
     my ($aref_1, $aref_2) = @_;
     my ($counter_1, $counter_2);
     my %freq_1 = counting($aref_1);
     my %freq_2 = counting($aref_2);
     my @intersection = 
          grep { $freq_1{$_} == 1 and $freq_2{$_} == 1 } # single common word
          grep { exists $freq_2{$_} } keys %freq_1; # intersection
     return 
          scalar
          @intersection;
}

sub counting
{
     my $aref = $_[0];
     my %hash;
     for my $item ( @$aref )
     {
          $hash{$item}++;
     }
     return %hash;
}
