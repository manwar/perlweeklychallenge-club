use strict;
use warnings;

use lib './lib';
use String;

my $string = join ' ', @ARGV;

my $output = String->num_sort($string);

print "\n$output\n";