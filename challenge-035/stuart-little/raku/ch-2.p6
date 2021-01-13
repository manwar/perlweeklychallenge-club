#!/usr/bin/env perl6
use v6;

# run as <script> <binary morse string>

use Convert::Morse:from<Perl5> <as_ascii>;

say @*ARGS[0].split('0' x 7).map(*.split('0' x 3).map({ S:g/\s+// with (S:g/111/-/ with $_).trans('10' => '. ') }).join(' ')).join('  ').&as_ascii;


