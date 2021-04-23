use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


package Calc;

use strict;
use warnings;

our $foo;
our @bar;
our %baz;

sub new { bless {}, shift; }
sub add { }
sub mul { }
sub div { }

1;

package main;

say " $_" for sort grep { defined &{"Calc::$_"} } keys %Calc::;
