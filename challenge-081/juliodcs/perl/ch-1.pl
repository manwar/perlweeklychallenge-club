use strict;
use warnings;
use feature 'say';
use List::MoreUtils 'uniq';

say for uniq map { /^(.+)\1+$/; $1 // () } @ARGV;
