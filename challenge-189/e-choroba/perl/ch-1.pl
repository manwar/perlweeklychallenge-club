#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ minstr };

sub greater_character ($array, $target) {
    minstr(grep $_ gt $target, @$array) // $target
}

use Test::More tests => 5 + 1;

is greater_character([qw[ e m u g ]], 'b'), 'e', 'Example 1';
is greater_character([qw[ d c e f ]], 'a'), 'c', 'Example 2';
is greater_character([qw[ j a r   ]], 'o'), 'r', 'Example 3';
is greater_character([qw[ d c a f ]], 'a'), 'c', 'Example 4';
is greater_character([qw[ t g a l ]], 'v'), 'v', 'Example 5';

is greater_character([], 'v'), 'v', 'Empty';
