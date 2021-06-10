#!/usr/bin/perl -s

use v5.16;
use warnings;
use experimental 'postderef';

# The task states "find the longest English words".  This could be meant
# as "all words having the maximum length".  My local dictionary has
# only one longest word of this kind, which does not qualify as "longest
# words" - a plural.
# Therefore I'll interpret the term "the longest words" in a way that
# multiple words may be found.
#
# Here $n defines "the longest words".  In addition to the word(s)
# having the maximum length, all lengths down to max_len - $n are
# considered as "long", resulting in a larger set of "longest words" if
# $n > 0.
our $n;
$n //= 1;

die <<EOS unless @ARGV;
usage: $0 [-n=<n>] dict...

-n=<n>
    Specify the maximum length difference from the maximum length for
    words to be printed.  Default: 1.  Use -n=0 to print the maximum
    length word(s) only.

dict...
    dictionary file name(s), e.g. /usr/share/dict/words

EOS


my @word;

while (<>) {
    chomp;
    $_ = lc;
    # Detect a "self-sorted" word and add it to an array of words having
    # the same length.
    push $word[length]->@*, $_ if join('', sort split //) eq $_;
}

# Reverse the order of the collected arrays, pick the first
# $n + 1 thereof, dereference these and print the words.
# @word may contain gaps.
say for map {$_ ? @$_ : ()} (reverse @word)[0 .. $n];
