#!/usr/bin/env raku
use Test;

is upper-lower('pERl'),   'PerL';
is upper-lower('rakU'),   'RAKu';
is upper-lower('PyThOn'), 'pYtHoN';

sub upper-lower($str)
{
    $str.subst(/(.)/, {$0 ~^ 32.chr}, :g)
}
