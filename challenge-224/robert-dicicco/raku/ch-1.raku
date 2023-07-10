#!/usr/bin/env raku
=begin comment
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-03
Challenge 224 Task 1 Special Notes ( Raku )
----------------------------------------------
=end comment
use v6;
my $flag = 0;
my $offset = 0;

sub MAIN ($source, $target) {
    while $offset < $target.chars {
        my $letter = substr($target, $offset, 1);
        unless $source.contains($letter) {
            say "Output: false";
            $flag = -1;
            last;
        }
        $offset++;
    }
    if ($flag == 0) {
        say "Output: true";
    }
}

=begin comment
----------------------------------------------
raku .\SpecialNotes.rk abc xyz
Output: false

raku .\SpecialNotes.rk scriptinglanguage perl
Output: true

raku .\SpecialNotes.rk aabbcc abc
Output: true
----------------------------------------------
=end comment


