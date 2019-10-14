#!/usr/bin/env perl
# Write a script to list dates for Sunday 
# Christmas between 2019 and 2100. 
# For example, 25 Dec 2022 is Sunday.

use strict;
use warnings;
use feature 'say';
use POSIX 'strftime';

map { !strftime("%w", 0, 0, 0, 25 , 11, $_ - 1900, -1, -1, -1) && say "12/25/$_" } 2019..2100;
=begin
perl .\ch-1.pl
12/25/2022
12/25/2033
12/25/2039
12/25/2044
12/25/2050
12/25/2061
12/25/2067
12/25/2072
12/25/2078
12/25/2089
12/25/2095
=cut