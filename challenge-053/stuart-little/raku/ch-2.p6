#!/usr/bin/env perl6
use v6;

sub allwstr(Int $l where * >= 0, %h) {
    given $l {
	when 0 { () }
	when 1 { %h.keys.sort }
	default {
	    allwstr($l-1, %h).map({ $_ X~ @(%h.{$_.substr(*-1)}).sort }).flat
	}
    }
}

my %h = (
    a => <e i>,
    e => <i>,
    i => <a e o u>,
    o => <a u>,
    u => <o e>,
);

say allwstr(@*ARGS[0].Int,%h);

# run as <script> <string length>
