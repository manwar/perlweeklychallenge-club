#!/usr/bin/env perl
use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# Task 1: Abecedarian Words
# Submitted by: Ryan J Thompson
#
# An abecedarian word is a word whose letters are arranged in alphabetical
# order. For example, “knotty” is an abecedarian word, but “knots” is not.
# Output or return a list of all abecedarian words in the dictionary, sorted in
# decreasing order of length.
#
# Optionally, using only abecedarian words, leave a short comment in your code
# to make your reviewer smile.

use FindBin ();

use lib $FindBin::RealBin;

use DictReader qw(read_dict);
use My::List::Util qw(group_by);

run() unless caller();

sub run() {
    my @dict = read_dict();

    # filter abecedarian words and group them by length.
    my $abecedarian_by_length = group_by( sub($a) { return length $a },
        grep( is_abecedarian($_), @dict ) );

    # output them sorted by length (shortest first). Since the input dict is
    # sorted lexically, all words of them same length will be output in lexical
    # order as well.
    say
      for map { @{ $abecedarian_by_length->{$_} } }
      sort    { $a <=> $b } keys %{$abecedarian_by_length};
}

sub is_abecedarian($word) {

    # To find out if a word is abecedarian we sort it lexically and compare to
    # the input words.
    return join( '', sort ( split( //, $word ) ) ) eq $word;
}
