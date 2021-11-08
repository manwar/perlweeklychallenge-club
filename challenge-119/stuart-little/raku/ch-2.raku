#!/usr/bin/env raku
use v6;

# run <script> <number>

sub nxt($str) {
    $str ~~ /(.*)(<-[3]>)(3*)$/;
    return ($1) ?? ($0.Str ~ ($1.Int+1) ~ substr('12' x $2.chars,0,$2.chars)) !! (substr('12' x $str.chars, 0, $str.chars+1));
}

my $out=0;
for (1..@*ARGS[0].Int) {
    $out=nxt($out);
}
say $out;


