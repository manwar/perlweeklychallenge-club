#!/usr/bin/env perl6
use v6;

# run <script> <path-to-file or nothing>
# defaults to text at the bottom if no file is entered

sub getNrs($data) {
    $data ~~ m:g/([\+\d ** 2|\(\d ** 2\)|\d ** 4]\s+ \d ** 10)/;
    return $/.map(*.Str);
}

my $data = (@*ARGS.elems) ?? (@*ARGS[0].IO.slurp) !! ($=finish);
for (getNrs($data)) {.say};

=finish
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
