use strict;
use warnings;
use Test::More tests => 4;

sub has_consecutive_odds {
my @array = @_;
my $count = 0;
for (my $i=0; $i<@array-2; $i++) {
if ($array[$i] % 2 == 1 && $array[$i+1] % 2 == 1 && $array[$i+2] % 2 == 1) {
$count++;
}
}
return $count > 0 ? 1 : 0;
}

ok(has_consecutive_odds(1,5,3,6), 'Example 1');
ok(!has_consecutive_odds(2,6,3,5), 'Example 2');
ok(!has_consecutive_odds(1,2,3,4), 'Example 3');
ok(has_consecutive_odds(2,3,5,7), 'Example 4');
