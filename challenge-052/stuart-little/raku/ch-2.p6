#!/usr/bin/env perl6
use v6;

sub isstep($n) {
    (($n.split('',:skip-empty) Z- $n.substr(1..*).split('',:skip-empty)).all ~~ *.abs==1).Bool
}

say (100..999).grep(&isstep);

# run as <script>
