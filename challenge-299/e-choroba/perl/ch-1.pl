#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub replace_words($sentence, @words) {
    # Why sort by length? Additional rule: use the longest matching
    # prefix if there are more possible ones.
    my $word_regex = join '|', sort { length $b <=> length $a } @words;
    $sentence =~ s/($word_regex)\w+/\1/g;
    return $sentence
}

use Test::More tests => 3 + 1;

is replace_words('the cattle was rattle by the battery', 'cat', 'bat', 'rat'),
    'the cat was rat by the bat', 'Example 1';

is replace_words('aab aac and cac bab', 'a', 'b', 'c'),
    'a a a c b', 'Example 2';

is replace_words('the manager was hit by a biker', 'man', 'bike'),
    'the man was hit by a bike', 'Example 3';

is replace_words('cat in a category of catalpa caterpillars', 'cat', 'cate'),
    'cat in a cate of cat cate', 'Same prefix';
