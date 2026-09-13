#!/usr/bin/env raku

use Test;

my @examples = (
    %{ in => "2[3[a]]",      out => "aaaaaa"     },
    %{ in => "10[a]",        out => "aaaaaaaaaa" },
    %{ in => "a2[b]c3[d]e",  out => "abbcddde"   },
    %{ in => "2[a2[b]c]",    out => "abbcabbc"   },
    %{ in => "1[a]2[b3[c]]", out => "abcccbccc"  },
);

is decode-string($_<in>), $_<out> for @examples;

done-testing;

sub decode-string($s is copy) {
    Nil while $s ~~ s:g/ (\d+) '[' (<-[ \[ \] ]>*) ']' /{$1 x $0}/;
    return $s;
}
