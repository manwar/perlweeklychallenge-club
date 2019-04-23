use strict;
use warnings;

my $x = shift;  # some number argument

for ( my $y = 2; $y <= $x; $y++ ) {
    next if $x % $y;
    $x /= $y;
    print $y, "\n";
    redo;
}

