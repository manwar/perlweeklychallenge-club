#!/bin/sh

perl -E 'say q{(}, (join q{, }, sort { $a <=> $b } map { $_ * $_ } @ARGV), q{)};' $@