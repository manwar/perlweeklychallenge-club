#!/usr/bin/perl
use warnings;
use strict;

use Lingua::EN::Numbers ();

*ordinal_number_spelling = *Lingua::EN::Numbers::num2en_ordinal;

use Test::More tests => 3;
is ordinal_number_spelling(11), 'eleventh',     'Example 1';
is ordinal_number_spelling(62), 'sixty-second', 'Example 2';
is ordinal_number_spelling(99), 'ninety-ninth', 'Example 3';
