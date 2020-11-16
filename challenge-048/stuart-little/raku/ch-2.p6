#!/usr/bin/env perl6
use v6;

say (Date.new(2000, 1, 1)..Date.new(2200, 12, 31)).grep({ $_.day == 2 || $_.day == 12 }).grep({ ($_.year %% 10) && (! $_.year %% 100) || ($_.year % 100 == (1,11,21).any ) }).map({ sprintf("%02d", $_.month) ~ sprintf("%02d", $_.day) ~ $_.year }).grep({ $_ eq $_.flip })

# run as <script>
