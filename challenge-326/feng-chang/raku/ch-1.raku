#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.Date.day-of-year;
