#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count how many are valid words. A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters, and at most one punctuation mark (!, ., ,) appearing only at the end.
Example 1

Input: $str = "cat and dog"
Output: 3

Tokens: "cat", "and", "dog"


Example 2

Input: $str = "a-b c! d,e"
Output: 2

Tokens: "a-b", "c!", "d,e"
"a-b" -> valid (one hyphen between letters)
"c!"  -> valid (punctuation at end)
"d,e" -> invalid (punctuation not at end)


Example 3

Input: $str = "hello-world! this is fun"
Output: 4

Tokens: "hello-world!", "this", "is", "fun"
All satisfy the rules.


Example 4

Input: $str = "ab- cd-ef gh- ij!"
Output: 2

Tokens: "ab-", "cd-ef", "gh-", "ij!"
"ab-"   -> invalid (hyphen not surrounded by letters)
"cd-ef" -> valid
"gh-"   -> invalid
"ij!"   -> valid


Example 5

Input: $str = "wow! a-b-c nice."
Output: 2

Tokens: "wow!", "a-b-c", "nice."
"wow!"  -> valid
"a-b-c" -> invalid (more than one hyphen)
"nice." -> valid

=cut

use Test2::V0 -no_srand => 1;
is(count_valid_tokens("cat and dog"), 3, 'Example 1');
is(count_valid_tokens("a-b c! d,e"), 2, 'Example 2');
is(count_valid_tokens("hello-world! this is fun"), 4, 'Example 3');
is(count_valid_tokens("ab- cd-ef gh- ij!"), 2, 'Example 4');
is(count_valid_tokens("wow! a-b-c nice."), 2, 'Example 5');

done_testing();

sub count_valid_tokens
{
     my $str = $_[0]; 
     my @tokens = grep is_valid($_), split(/\s/, $str);
     return scalar @tokens;
}

sub is_valid
{
     my $str = $_[0]; 
     return 0 if $str !~ /[a-z]/;
     return 0 if $str =~ /[0-9]/;
     for my $chr ( '-', '.', '!', ',' )
     {
          my $number = () = $str =~ /\Q$chr\E/g; 
          return 0 if $number > 1;
     }
     return 0 if $str =~ /^\-|\-$/;
     for my $chr ( '.', '!', ',' )
     {
          return 0 if $str =~ /\Q$chr\E[a-z]/;
     }
     return 1;
}
