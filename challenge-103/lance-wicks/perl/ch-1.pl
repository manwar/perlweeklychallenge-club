use strict;
use warnings;

use lib './lib';
use Zodiac;

my $zodiac = Zodiac->new;

print $zodiac->sign_from_year($ARGV[0]);
print "\n";
