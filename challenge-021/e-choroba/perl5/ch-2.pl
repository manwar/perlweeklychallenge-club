#! /usr/bin/perl
use warnings;
use strict;

use URI::URL;

my $url = 'URI::URL'->new('HTTP://Example.com:80/Path/a%c2%b1b%7e');

use Test::More tests => 1;
is $url, 'http://example.com/Path/a%C2%B1b~', 'normalized';
