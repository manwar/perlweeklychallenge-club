#!/usr/bin/env perl6
use v6;

# run <script> <path-to-module>
# defaults to the Test module

my $modPath = @*ARGS[0];
my $modDir = ($modPath) ?? ($modPath.IO.dirname) !! (".");

use lib "./TMP";

(! $modPath) && do {
    use Test;
    say Test::EXPORT::ALL::.keys.grep(*.starts-with('&'));
    exit
}

my $mod = S/(.*)\..*/$0/ with $modPath.IO.basename;
mkdir 'TMP';
shell(qq|cp $modPath ./TMP/{$mod}.rakumod|);
require ::($mod);
say ::("{$mod}::EXPORT::ALL").WHO.keys.grep(*.starts-with('&'));
shell(qq|rm -rf ./TMP|);
