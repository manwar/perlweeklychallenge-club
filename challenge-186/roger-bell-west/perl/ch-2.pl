#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use utf8;
use Text::Unidecode;

use Test::More tests => 2;

is(unidecode("ÃÊÍÒÙ"), "AEIOU", 'example 1');

is(unidecode("âÊíÒÙ"), "aEiOU", 'example 2');
