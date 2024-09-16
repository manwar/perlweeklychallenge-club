#!/usr/bin/raku

$*PROGRAM-NAME.IO.lines.tail.split(/\x2E/).pick(1).join.say;