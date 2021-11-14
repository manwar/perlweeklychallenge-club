#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string of delimiter pairs and a string to search.Write a script to return two strings, the first with any characters matching the “opening character” set, the second with any matching the “closing character” set.

Example 1:

Input:
    Delimiter pairs: ""[]()
    Search String: "I like (parens) and the Apple ][+" they said.

Output:
    "(["
    ")]"

Example 2:

Input:
    Delimiter pairs: **//<>
    Search String: /* This is a comment (in some languages) */ <could be a tag>
Output:
    /**/<
    /**/>

=cut
use utf8; 
# The problem is probably to call a string function with a string that can 
# contain delimiters itself. A possible solution: to have a delimiter at 
# the quote-like operator that would not occur in the string.
# Here, the delimiter in the function call is \N{CYRILLIC CAPITAL LETTER HARD SIGN},
# which is highly unlikely to occur in the following text. :-)

my @pair = find_delimiter(q Ъ""[]()Ъ, q Ъ"I like (parens) and the Apple ][+" they said.Ъ);
print join($/, @pair), $/;
@pair = find_delimiter(q Ъ**//<>Ъ , q Ъ/* This is a comment (in some languages) */ <could be a tag>Ъ);
print join($/, @pair), $/;


sub find_delimiter
{
     my ($del_pairs, $string) = @_;
     my @delimiter = split(//, $del_pairs);
     my (%opening, %closing);
     @opening { @delimiter[ grep $_ % 2 == 0, 0 .. $#delimiter ] } = undef;
     @closing { @delimiter[ grep $_ % 2 == 1, 0 .. $#delimiter ] } = undef;
     my @characters = split(//, $string);

     my @this_opening = grep exists $opening{$_}, @characters;
     my @this_closing = grep exists $closing{$_}, @characters;
     return join('', @this_opening), join('', @this_closing);
}