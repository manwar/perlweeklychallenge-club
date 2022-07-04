#!/usr/bin/env raku

# ch-2.raku - Function composition
#
# 2022 Ryan Thompson <rjt@cpan.org>

my &sum    = sub {    [+] @_ };
my &square = sub { @_ »*« @_ };

my &h = &sum ∘ &square;

say &h(1..10);
