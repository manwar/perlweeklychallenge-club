#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Text::JaroWinkler qw{ strcmp95 };

say strcmp95('CRATE', 'TRACE', 5);

