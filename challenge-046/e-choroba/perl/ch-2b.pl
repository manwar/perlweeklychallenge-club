#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

say join ' ', map $_ ** 2, 1 .. sqrt 500;
