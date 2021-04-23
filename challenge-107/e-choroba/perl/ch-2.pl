#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use lib './lib';
use Calc ();

say for keys %{Calc::};

# Inlining the package in the main file excludes the BEGIN. Not
# specifying the "no import ()" adds "import" to the list.
