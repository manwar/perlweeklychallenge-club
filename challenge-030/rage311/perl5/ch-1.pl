#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;

use Time::Piece;

say for grep { Time::Piece->strptime("$_-12-25", '%Y-%m-%d')->wday == 1 } 2019..2100;


__DATA__
Write a script to list dates for Sunday Christmas between 2019 and 2100. For example, 25 Dec 2022 is Sunday.

