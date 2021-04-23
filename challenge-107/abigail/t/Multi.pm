package Multi;

use strict;
use warnings;
use 5.010;

our $Multi = 2;
our @Multi = (3, 4, 5);
our %Multi = (6 => 7, 8 => 9);
open Multi, "<", "does not exist";
sub  Multi { }

1;
