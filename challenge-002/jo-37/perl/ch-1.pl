#!/usr/bin/perl

use 5.012;
use strict;
use warnings;

say join "\n", map $_ + 0, '000123', 123;
