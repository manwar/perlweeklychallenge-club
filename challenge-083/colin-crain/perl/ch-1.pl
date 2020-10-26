#! /opt/local/bin/perl
#
#       no-not-that-word-the-other-word.pl
#
#         TASK #1 › Words Length
#         Submitted by: Mohammad S Anwar
#             You are given a string $S with 3 or more words.
# 
#             Write a script to find the length of the string except the first
#             and last words ignoring whitespace.
# 
#             Example 1:
#                 Input: $S = "The Weekly Challenge"
#                 Output: 6
#                 
#             Example 2:
#                 Input: $S = "The purpose of our lives is to be happy"
#                 Output: 23
# 
#         method: 
#             what defines a word? Overthinking this as usual, the obvious
#             division is whitespace. Considering for a minute we do have
#             options, such as the "word boundry" \b character class.
# 
#             Yea, that's going to choke on apostrophes and hyphens, so, no.
#             We'll keep it simple and say the things at the front and back that
#             extend up to the whitespace are the first and last words. 
# 
#             A simple, straightforward way to go about this is to trim whitespace
#             from the front and back and then split the string on remaining whitespace,
#             giving a list of words. Using an array slice we ignore the first and last 
#             element on this list, then sum the lengths for the remaining elements. 
#             
#             We could have as easily joined the words and taken the length of the 
#             resultant string, or used a regex to substitute out words anchored to the 
#             front and back before again substituting out remaining whitespace. That 
#             last one sounds nice but I didn't do it. Writing this probably took more 
#             time. 
#             
#             $_ = shift || " The purpose of our lives is to be happy ";
#             s/^\s*\w+|\w+\s*$//g;
#             s/\s+//g;
#             say length $_;
#             
#             There. Happy? 

#             No? Oh, come on man! Fine.
# 
#             The regular expression engine operates from left to right when
#             examining options, so the left word is removed first, then the
#             right word is searched for and removed. Extending this rationale,
#             we can roll the second expression into the first, as another
#             option at the end. The first parts hinge on stopping when we get
#             to whitespace, but these spaces are not removed until after these
#             other parts operate. We can also remove the variable. Why not?
# 
#             $_ = $ARGV[0];
#             s/ ^\s* \S+ | \S+ \s*$ | \s+ //xg;
#             say length $_;
# 
#             or even as a one-liner:
# 
#             perl -e '$_=$ARGV[0];s/^\s*\S+|\S+\s*$|\s+//xg;print length $_, "\n"'
# 
# 
#             
#             
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $S = $ARGV[0] || " The purpose of our lives is to be happy ";
my $sum;

$S =~ s/^\s+|\s+$//g;
my @s = split /\s+/, $S;
say 0 if @s < 3;

$sum += length $_ for @s[1..$#s-1];

say $sum;


## the shorter, cleverer way
## the substitution evaluates the options in left-to-right order,
## so we remove the left word, the right word and then any other whitespace
$_ = $ARGV[0] || " The purpose of our lives is to be happy ";
s/ ^\s* \S+ | \S+ \s*$ | \s+ //xg;
say length $_;

