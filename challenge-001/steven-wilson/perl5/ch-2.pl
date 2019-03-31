#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-03-25
# Challenge #2
# Write one-liner to solve FizzBuzz problem and print number 1-20. However, 
# any number divisible by 3 should be replaced by the word fizz and any 
# divisible by 5 by the word buzz. Numbers divisible by both become fizz buzz.

use warnings;
use strict;
use feature qw / say /;

map { if(!($_ % 3) && !($_ % 5)){ say 'fizz buzz'} else { if(!($_ % 3)){ say 'fizz'} elsif(!($_%5)) {say 'buzz'} else {say $_} }} 1..20;
