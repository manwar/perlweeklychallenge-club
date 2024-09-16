#!/usr/bin/env raku

unit sub MAIN;

slurp $?FILE
andthen .words
andthen .pick
andthen .put
