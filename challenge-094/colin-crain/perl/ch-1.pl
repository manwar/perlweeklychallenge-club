#! /opt/local/bin/perl
#
#       anagram_clusters.pl
#
#         TASK #1 › Group Anagrams
#         Submitted by: Mohammad S Anwar
#         You are given an array of strings @S.
#
#         Write a script to group Anagrams together in any random order.
#
#         An Anagram is a word or phrase formed by rearranging the letters of a
#         different word or phrase, typically using all the original letters
#         exactly once.
#
#         Example 1:
#             Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
#             Output: [ ("bat", "tab"),
#                       ("saw", "was"),
#                       ("top", "pot", "opt") ]
#         Example 2:
#             Input: ("x")
#             Output: [ ("x") ]

#         method:
#             I think the definition of an anagram, while nice, and
#             important mind you, is in the end a little less useful than a more
#             definitive rephrasing of the first sentence would be. I have to
#             say I couldn't make heads or tails of it the first time I read it.
#             Wait, what anagrams of what? Grouping random anagrams? From where again?
#
#             After carefully deconstructing the examples it did become clear
#             what was expected, so let's try that rephrase: "Given a list of
#             strings, group together in any order those strings that represent
#             anagrams of each other." Does that make more sense? In the frist
#             example, "bat" and "tab" are anagrams, as are "saw" and "was", and
#             "top", "pot" and "opt".

#             To do this we'll need only to know how many of each letter compose
#             the word, the order is unimportant. The easiest way to do that is
#             to sort the letters and keep the count in unary notation, such as
#             converting the word notation into ainnoott. Any other anagram will
#             convert to the same form, so if we use it as a hash key, we can
#             keep the words that match as a list in the values.
#
#             It's worth noting that hash keys, like the hashes themselves,
#             don't concern themselves much with physical size. Any string can
#             be used for a hash key; with non-interpolating single quotes any
#             character can be contined.


#             Reporting the key and their value lists gives us the result we
#             desire.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

@ARGV == 0 and @ARGV = ("Opt", "bat", "saw1", "tab", "po-t", "top", "wa's");

my @list;
for (@ARGV) {
    s/[^a-zA-Z]//g;
    push @list, lc $_;
}

my %letters;
for (@list) {
    my $str = join '', sort split //, $_;
    push $letters{$str}->@*, $_;
}

say "@$_" for values %letters;


