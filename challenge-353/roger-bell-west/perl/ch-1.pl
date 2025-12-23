#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxwords(['Hello world', 'This is a test', 'Perl is great']), 4, 'example 1');
is(maxwords(['Single']), 1, 'example 2');
is(maxwords(['Short', 'This sentence has six words in total', 'A B C', 'Just four words here']), 7, 'example 3');
is(maxwords(['One', 'Two parts', 'Three part phrase', '']), 3, 'example 4');
is(maxwords(['The quick brown fox jumps over the lazy dog', 'A', 'She sells seashells by the seashore', 'To be or not to be that is the question']), 10, 'example 5');

use List::Util qw(max);

sub maxwords($a) {
  max(map {scalar split ' ', $_} @{$a});
}
