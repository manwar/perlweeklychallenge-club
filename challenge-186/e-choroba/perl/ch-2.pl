#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';
use utf8;

use Text::Unidecode;

*unicode_makeover = *Text::Unidecode::unidecode;

use Test::More tests => 2;

is unicode_makeover('ÃÊÍÒÙ'), 'AEIOU', 'Example 1';
is unicode_makeover('âÊíÒÙ'), 'aEiOU', 'Example 2';
