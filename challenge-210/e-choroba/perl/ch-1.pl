#! /usr/bin/perl
use warnings;
use strict;

# In the end, all the numbers must be exhausted (easy to prove by
# contradiction), so their total is just the sum of all the numbers.

use Importer 'List::Util' =>
    sum => {-as => 'kill_and_win'};

use Test::More tests => 2;

is kill_and_win(2, 3, 1), 6, 'Example 1';
is kill_and_win(1, 1, 2, 2, 2, 3), 11, 'Example 2';
