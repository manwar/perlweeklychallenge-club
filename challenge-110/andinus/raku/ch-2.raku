#!/usr/bin/env raku

unit sub MAIN (Str $file where *.IO.f = "input-ch2");

.say for zip($file.IO.lines.map(*.split(","))).map(*.join(","));
