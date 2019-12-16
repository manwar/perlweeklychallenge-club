#!/usr/bin/env bash
perl6 -e 'put join ", ",(1..20).map: {my $o; $o="fizz" if $_ %% 3; $o~="buzz" if $_ %% 5; $o??$o!!$_}'
