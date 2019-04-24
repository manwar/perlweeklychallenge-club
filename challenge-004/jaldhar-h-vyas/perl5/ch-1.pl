#!/usr/bin/perl
use constant SIZE => 7;
use warnings;
use strict;
use English qw/ -no_match_vars /;
use Math::BigFloat;
use 5.010;

say Math::BigFloat->bpi((stat $PROGRAM_NAME)[SIZE]);
