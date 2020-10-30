use strict;
use warnings;
use feature "say";
use constant MAX => 2 ** 31 - 1; # i.e. 2_147_483_647

my $input = shift  // 1234;
my $positive = 1;
if ($input < 0) {
    $positive = 0;
    $input = -$input;
}
my $output = reverse $input;
$output = 0 if $positive and $output > MAX;
$output = 0 if $output > MAX + 1;
# No specification for inputs ending with 0
# We numify $output and negate it if needed
$output = $positive ? $output + 0 : -$output;
say $output;
