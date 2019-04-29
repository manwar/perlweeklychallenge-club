#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#
# I am assuming that we really wanted Ramanujan's Constant, and not the
# linked to Wiki page on the Landau-Ramanujan Constant which is
# something else entirely!
#
# Checked against http://oeis.org/A060295

# We'll give *33* digits of precison, not 32.  ;)
# Formula is from the Wiki page.  :)  It's accurate to 33 digits.
say (640320³ + 744 - 196844.FatRat/(640320³ + 744)).Str.substr(0,34);

