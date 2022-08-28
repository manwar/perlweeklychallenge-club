#!/usr/bin/env raku
use Lingua::EN::Numbers;
use Test;

is ordinal(11), 'eleventh';
is ordinal(62), 'sixty-second';
is ordinal(99), 'ninety-ninth';
