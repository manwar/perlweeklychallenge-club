#!/usr/bin/env raku
use Test;

is-deeply build-array(<0 2 1 5 3 4>), <0 1 2 4 5 3>;
is-deeply build-array(<5 0 1 2 3 4>), <4 5 0 1 2 3>;

sub build-array(@a) { @a[@a] }
