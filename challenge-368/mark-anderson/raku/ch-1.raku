#!/usr/bin/env raku
use Test;

is make-it-bigger(15456,  5), 1546;
is make-it-bigger(7332,   3), 732;
is make-it-bigger(2231,   2), 231;
is make-it-bigger(543251, 5), 54321;
is make-it-bigger(1921,   1), 921;

sub make-it-bigger($str is copy, $char)
{
    $str ~~ s:1st/ $char (\d) <?{ $char < $0 }> /$0/; 
 
    unless $/
    {
        $str ~~ s:nth(*)/$char//
    }

    $str
}
