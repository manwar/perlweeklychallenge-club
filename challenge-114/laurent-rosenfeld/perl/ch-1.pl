use strict;
use warnings;
use feature "say";

my $num = shift // 1234;
$num =~ s/^0+//; # remove leading 0s just in case
while (++ $num) {
    say $num and last if $num eq reverse $num;
}
