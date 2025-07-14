#!/usr/bin/env raku
use Test;

is title-capital("PERL IS gREAT"),        "Perl is Great";
is title-capital("THE weekly challenge"), "The Weekly Challenge";
is title-capital("YoU ARE A stAR"),       "You Are a Star";

sub title-capital($str)
{
    $str.lc.wordcase(:where({ .chars > 2 })) 
}
