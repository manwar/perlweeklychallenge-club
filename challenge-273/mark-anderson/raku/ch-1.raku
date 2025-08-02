#!/usr/bin/env raku
use Test;

is perc-of-char('perl',      'e'), 25;
is perc-of-char('java',      'a'), 50;
is perc-of-char('python',    'm'),  0;
is perc-of-char('ada',       'a'), 67;
is perc-of-char('ballerina', 'l'), 22;
is perc-of-char('analitik',  'k'), 13;

sub perc-of-char($str, $char)
{
    round 100 * $str.indices($char) / $str.chars
}
