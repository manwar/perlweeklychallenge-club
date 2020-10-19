#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# You are given a string $S with 3 or more words.
#
# Write a script to find the length of the string except the first
# and last words ignoring whitespace.
#


#
# It's not a given the input is in ASCII, so, we're assuming UTF8.
# We need to tell Perl we're expecting input in UTF8.
#
binmode STDIN, ":encoding(UTF-8)" or die "binmode: $!";
 

#
# So, what is a word? \w+ sounds like a good idea, but that doesn't
# capture words like "O'Reilly", hyphenated words,  or words consisting
# of letter with combining characters. It also matches things like ___
# or 123, which perhaps should not be considered words.
#
# A letter followed by zero or more combining combining characters is
# matched by \X, but \X also matches non-word characters. So, for a
# letter with combining characters, we can match it with:
#
#      (?:(?=\pL)\X*)
#
# Now, words can start or end with a ', or contain ' or - internally.
# And while we will allow '- and -' internally, we don't allow double
# '' or double --, nor any string of more than two of them. 
#
# We also require the sub strings consisting of letters (with their
# combining characters) to be bounded by grapheme cluster boundary.
#
# This results in the following pattern for a word:
#
#

my $word =
     qr [(?(DEFINE)
            (?<LETTERS>   \b{gcb} (?:(?=\pL)\X)+ \b{gcb})
            (?<SEPARATOR> ['-] | '- | -')
            (?<START>     '?)
            (?<END>       '?)
         )
          (?&START)
          (?&LETTERS) (?: (?&SEPARATOR) (?&LETTERS) ) *
          (?&END)]x;


# 
# Now that we have a pattern for a word, we can remove the first
# and last words. Removing the first match is easy, as Perl will, by
# default, pick the left most possible match. 
#
# The last word is slightly more tricky. It's important to realize
# than, by our definition, any word contains at least a letter, and
# any letter is part of a word. So, if we match a word, followed by
# a, possibly empty, string of non-letters, followed by the end of 
# the string, we have the last word.
#
# After removing the first and last word, all we're left with is
# removing whitespace, and getting the length of what is left over.
#

while (<>) {
    chomp;
    s/$word//;
    s/$word(?=\P{l}*$)//;
    s/\s+//g;
    say length;
}
  

__END__
