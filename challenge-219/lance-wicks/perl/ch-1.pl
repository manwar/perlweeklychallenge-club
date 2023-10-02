use strict;
use warnings;

use lib './lib';
use My::Sorted::Square;

my $list_txt = join ", ", @ARGV;
print "Input: \@list = ($list_txt)\n";

my @squares    = My::Sorted::Square->run(@ARGV);
my $output_txt = join ", ", @squares;
print "Output: ($output_txt)\n";

