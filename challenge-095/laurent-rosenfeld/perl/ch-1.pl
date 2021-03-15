use strict;
use warnings;
use feature "say";

my $num = shift // 1221;
say "$num: ", $num eq (reverse $num) ? 1 : 0;
