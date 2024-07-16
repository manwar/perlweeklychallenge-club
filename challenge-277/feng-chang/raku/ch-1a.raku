#!/bin/env raku

unit sub MAIN(Str:D \s1, Str:D \s2);

put +[(&)] (s1, s2).map({ .grep(.one) with .words.List });
