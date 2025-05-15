#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

put redact($s1) eq redact($s2);

sub redact(Str:D $s is copy --> Str:D) {
    $s .= subst(/. '#'/) while $s.contains('#');
    $s
}
