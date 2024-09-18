#! /usr/bin/env raku

unit sub MAIN ($str, :v(:$verbose));

say ":Match Object: ", ( $str ~~ /^(<[+-]>?)(\d*)(\.?)(\d*)(<[eE]><[+-]>?\d+)?$/) if $verbose;

say so $str ~~ /^(<[+-]>?)(\d*)(\.?)(\d*)(<[eE]><[+-]>?\d+)?$/ && ($1.Str || $3.Str);

