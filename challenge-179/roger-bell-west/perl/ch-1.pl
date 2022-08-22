#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Lingua::EN::Numbers qw(num2en_ordinal);

use Test::More tests => 3;

is(num2en_ordinal(11),"eleventh",'example 1');
is(num2en_ordinal(62),"sixty-second",'example 2');
is(num2en_ordinal(99),"ninety-ninth",'example 3');
