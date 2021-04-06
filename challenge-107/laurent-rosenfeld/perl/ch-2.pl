use strict;
use warnings;
use feature qw /say/;

while (<>) {
    say $1 if /^\s*sub\s+(\w+)/;
}
