#!/usr/bin/env perl6
use v6;

sub gray($n) {
    ($n==1) && return <0 1>.List;
    return (.map({ 0~$_}), .reverse.map({ 1~$_})).flat.List with gray($n-1);
}

say gray(@*ARGS[0].Int).map({ :2($_)});

# run as <script> <size>
