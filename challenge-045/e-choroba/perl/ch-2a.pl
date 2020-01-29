#!/usr/bin/perl
use warnings;
use strict;

seek *DATA, 0 , 0;
print while <DATA>;
__DATA__

