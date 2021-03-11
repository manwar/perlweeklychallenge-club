#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';

use v5.20;

use HashCounting qw( h );

say h(42);
