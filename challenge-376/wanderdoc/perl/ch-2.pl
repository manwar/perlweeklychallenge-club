#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string (which may contain embedded newlines) which is taken from a page on a website. The string will not contain brackets qw{ [ ] }.
Write a script that will find doubled words (such as “this this”) and highlight (wrap in brackets) each doubled word.

The script should:

- Work across lines, even finding situations where a word at the end of
  one line is repeated at the beginning of the next.

- Find doubled words despite capitalization differences, such as with
  'The the...', as well as allow differing amounts of whitespace (spaces,
  tabs, newlines, and the like) to lie between the words.

- Find doubled words even when separated by HTML tags. For example, to
  make a word bold: '...it is <B>very</B> very important...'. Only show
  lines containing doubled words.

  
Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl
Example 1

Input: $str = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."
Output: "web server for doubled words (such as '[this] [this]'), a common problem"


Example 2

Input: $str = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."
Output: "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"

Example 3

Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."


Example 4

Input: $str = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."
Output: ""

Example 5

Input: $str = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
Output: "There's more than [one] [one] way to do it."

=cut

use Test2::V0 -no_srand => 1;

is(doubled_words("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."), "web server for doubled words (such as '[this] [this]'), a common problem", "Example 1");
is(doubled_words("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."), "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,", "Example 2");
is(doubled_words("to make a word bold: '...it is <B>very</B> very important...'."), "to make a word bold: '...it is <B>[very]</B> [very] important...'.", "Example 3");
is(doubled_words("Perl officially stands for Practical Extraction and Report Language, except when it doesn't."), "", "Example 4");
is(doubled_words("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."), "There's more than [one] [one] way to do it.", "Example 5");
done_testing();

sub doubled_words
{
     my $str = $_[0];
     my $tag_re = qr/<\/?[^<>]+>/; 
     my $between_re = qr/\s+|$tag_re\s*/; 

     my $interim_string = '';
     if (  $str =~ /(?<word>\b\w+\b)($between_re)(\k<word>)/msi )
     {
           $interim_string = $`. '['. $1. ']'. $2. '['. $3. ']'. $';
     }
     my $output = 
          join("\n",
          grep { /\[/ } split(/\n/, $interim_string));

     return $output;
 }
