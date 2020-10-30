#!/usr/bin/env perl6
use v6;

multi interl("", Str $snd, Str $tot) {
    $tot eq $snd;
}

multi interl(Str $fst, "", Str $tot) {
    $tot eq $fst;
}

multi interl(Str $fst, Str $snd, Str $tot) {
    (($fst.substr(0,1) eq $tot.substr(0,1)) && interl($fst.substr(1),$snd,$tot.substr(1)))
    ||
    (($snd.substr(0,1) eq $tot.substr(0,1)) && interl($fst,$snd.substr(1),$tot.substr(1)))
}

say interl(|@*ARGS[0,1,2]);

# run as <script> string1 string2 possible-compound-string
