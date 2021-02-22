#!/opt/perl/bin/perl

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# For the challenge description, see ../README.md
#

#
# The challenge doesn't describe what a word is, or what to
# do with things which are neither words, nor whitespace, like
# punctuation.
#
# For instance, what should happen to the sentence:
#
#     "The Weekly Challenge, Part 1!"
#
# So, we're using the easy way out, and assume anything which isn't
# whitespace to be part of a word. After all, the examples assumen
# all the world is ASCII letters and spaces.
#
# Which makes the excercise too trivial to be called a challenge.
#

# Extract 'words', reverse the list, and print it.
say join " " => reverse /\S+/g for <>;
