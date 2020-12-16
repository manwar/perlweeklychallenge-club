#!/usr/bin/env perl6
use v6;

# run as <script> <URL>

use URI:from<Perl5>;

say URI.new(@*ARGS[0]).canonical.Str;

