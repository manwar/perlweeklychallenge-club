#! /usr/bin/env raku

unit sub MAIN ($date where $date ~~ /^ \d\d\d\d \- \d\d \- \d\d $/);

say $date.split('-').map( *.fmt('%b') ).join('-');
