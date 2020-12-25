#!/usr/bin/env perl6
use v6;

# run as <script> <quoted string>

use Convert::Morse:from<Perl5> <as_morse is_morsable>;

my $input=@*ARGS[0].split('',:skip-empty).grep(*.&is_morsable).join;
say S:g/0 ** 5/$('0' x 7)/ with {'.' => 1, '-' => 111, ' ' => 0}.{$input.&as_morse.split('',:skip-empty)}.join(0)
