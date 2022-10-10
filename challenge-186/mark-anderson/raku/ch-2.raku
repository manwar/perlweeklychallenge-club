#!/usr/bin/env raku
use Test;

is 'ÃÊÍÒÙ'.samemark('a'), 'AEIOU';
is 'âÊíÒÙ'.samemark('a'), 'aEiOU';
