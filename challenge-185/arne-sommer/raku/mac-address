#! /usr/bin/env raku

multi sub MAIN ($mac-dot where /^ <[0..9a..f]> **4 . <[0..9a..f]> **4 . <[0..9a..f]> **4 $/)
{
  say $mac-dot.split(".")>>.map({ $_.substr(0,2) ~ ":" ~ $_.substr(2,2) }).join(":");
}

multi sub MAIN ($mac-colon where /^ <[0..9a..f]> **2 \: <[0..9a..f]> **2 \: <[0..9a..f]> **2 \: <[0..9a..f]> **2 \: <[0..9a..f]> **2 \: <[0..9a..f]> **2 $/)
{
  say $mac-colon.split(":").rotor(2)>>.join.join(".");
}
