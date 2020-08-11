#! /opt/local/bin/perl
#       HistoryThing.pl
#
#       task:   Write a script that allows you to capture/display
#                       historical data. It could be an object or a scalar.
#                       For example
#
#                   my $x = 10; $x = 20; $x -= 5;
#
#               After the above operations, it should list $x historical value in order.
#
#       method: in the script below, with its related package, h is an object that holds
#               two values, x and y. The name and number of values is easily extendable.
#               Altering the values for either variable results in the new value recorded
#               to a historical list of values that is maintained and can be viewed by
#               calling the 'history' method with the name of the variable in question.
#
#               uses a moo object. I like moo.
#
#       (c) 2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use lib '.';        ## park HistoryThing.pm alongside

use HistoryThing;

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $h = new HistoryThing;

## set some values for x
$h->x(1);
say "x at start: ", $h->x;

$h->x(2);
$h->x(-1);
$h->x('foo');
say "x is currently: ", $h->x;

## set some values for y
$h->y(3);
say "y at start: ", $h->y;

$h->y(4);
$h->y(-5);
$h->y('bar');
say "y is currently: ", $h->y;

say "history of x: ", $h->get_hist('x');
say "history of y: ", $h->get_hist('y');


