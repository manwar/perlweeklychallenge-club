#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two sentences.

Write a script to return list of all uncommon words, order is not important.
Example 1

Input: $sentence1 = "apple banana apple"
       $sentence2 = "banana orange"
Output: ("orange")

Example 2

Input: $sentence1 = "cat dog"
       $sentence2 = "bird fish"
Output: ("cat", "dog", "bird", "fish")

Example 3

Input: $sentence1 = "the quick brown fox"
       $sentence2 = "the quick"
Output: ("brown", "fox")

Example 4

Input: $sentence1 = "hello"
       $sentence2 = "hello"
Output: ()

Example 5

Input: $sentence1 = "blue blue red"
       $sentence2 = "red green green yellow"
Output: ("yellow")
=cut


use Test2::V0 -no_srand => 1;
is([uncommon_words("apple banana apple", "banana orange")], 
     ["orange"], 'Example 1');
is([uncommon_words("cat dog", "bird fish")], 
     bag{item "cat"; item "dog"; item "bird"; item "fish"; end()}, 
     'Example 2');
is([uncommon_words("the quick brown fox", "the quick")], 
     bag{item "brown"; item "fox"; end()}, 'Example 3');

is([uncommon_words("hello", "hello")], [], 'Example 4');
is([uncommon_words("blue blue red", "red green green yellow")], 
     ["yellow"], 'Example 5');
done_testing();



sub uncommon_words
{
     my ($str_1, $str_2) = @_;
     my %first =  _create_dictionary($str_1);
     my %second = _create_dictionary($str_2);
     for my $key_2( keys %second)
     {
          $first{$key_2} += $second{$key_2};
     }
     my @output = grep { $first{$_} == 1 } keys %first;

     return @output;
}

sub _create_dictionary
{
     my $str = $_[0];
     my %hash;
     for my $word (split(" ", $str) )
     {
          $hash{$word}++;
     }
     return %hash;
}
