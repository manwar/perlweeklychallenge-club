#!/usr/bin/env raku
use Test;

nok string-alike("textbook");
ok  string-alike("book");
ok  string-alike("AbCdEfGh");
nok string-alike("rhythmmyth");
nok string-alike("UmpireeAudio");

sub string-alike($str)
{
    my $n = $str.chars div 2;

    my $left  = ($str.substr(0, $n) ~~ m:g:i/< a e i o u >/).elems;
    my $right = ($str.substr(*-$n)  ~~ m:g:i/< a e i o u >/).elems;

    so all $left, $right, $left == $right
}
