#!/usr/bin/perl
use warnings;
use strict;

{   package PWC217_2;
    use FindBin ();
    sub max_number;
    do "$FindBin::Bin/../../../challenge-217/e-choroba/perl/ch-2.pl";
}

*largest_number = *PWC217_2::max_number{CODE};

use Test::More tests => 2;

is largest_number(20, 3), 320, 'Example 1';
is largest_number(3, 30, 34, 5, 9), 9534330, 'Example 2';
