#!/usr/bin/env raku

unit sub MAIN(Str $file, UInt $from, UInt $to where 1 <= $from <= $to);
 
print |$file.IO.lines(chomp => False)[$from-1 .. $to-1];
