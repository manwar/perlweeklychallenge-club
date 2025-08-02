#!/usr/bin/env raku
use v6.d;

=begin comment
286-1: Self Spammer
Submitted by: David Ferrone
Write a program which outputs one word of its own script / source code at random. A word is anything between whitespace, including symbols.
…
=end comment

say $*PROGRAM-NAME.IO.slurp.words.pick;
