package Test;

use strict;
use warnings;
use 5.010;

our $scalar = 1;
our @array  = (1, 2, 3);
our %hash   = (1 => 2);
open FH, "<", "does not exist";
sub sub_routine { }

1;
