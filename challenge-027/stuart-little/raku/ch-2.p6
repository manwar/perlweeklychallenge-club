#!/usr/bin/env perl6
use v6;

# run as <script>
# 
# learned of STORE from
# https://rosettacode.org/wiki/History_variables#Raku

class HistVar {
    has @!history;
    has $!var handles <Str gist>;
    method STORE($val) is rw {
        $!var.defined && push @!history, $!var;
	say ((@!history) ?? ("was: {@!history};  ") !! ""), "is now: {$val}";
        $!var = $val;
    }
}

my @x is HistVar.new;

@x=1;
@x=2;
@x=3;
@x=4;

say "current: {@x}";
