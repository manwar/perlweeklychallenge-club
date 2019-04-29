#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

use bignum;

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#
# I am assuming that we really wanted Ramanujan's Constant, and not the
# linked to Wiki page on the Landau-Ramanujan Constant which is
# something else entirely!
#
# Checked against http://oeis.org/A060295

# We'll give *33* digits of precison, not 32.  ;)
# Formula is from the Wiki page.  :)  It's accurate to 33 digits.
say substr(640320**3 + 744 - 196844/(640320**3 + 744), 0, 34);

