#!/bin/sh

perl -E 'my $x=shift @ARGV;say q{(},(join q{, },(split //,($x+join q{}, @ARGV))),q{)}' "$@"
