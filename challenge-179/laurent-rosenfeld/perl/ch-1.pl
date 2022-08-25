use strict;
use warnings;
use feature qw/say/;

use Lingua::EN::Numbers qw/num2en_ordinal/;

for my $num (11, 62, 99) {
    say "$num => ", ordinal($num);
}
