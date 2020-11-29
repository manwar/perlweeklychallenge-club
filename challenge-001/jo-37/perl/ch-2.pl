#!/usr/bin/perl

use 5.012;
use strict;
use warnings;

say join ', ', map $_%15?$_%5?$_%3?$_:'fizz':'buzz':'fizzbuzz', 1 .. 20;


