use strict;
use warnings;
use 5.010;
use open qw<:std :utf8>;
no warnings qw<portable>;

my @lines = map { (reverse sprintf '%b', $_) =~ tr/01/ \N{FEMALE SIGN}/r }
            qw<0 248 260 514 1025 32>;

say for @lines[split '', 0x2BDB34EABC62D3];
