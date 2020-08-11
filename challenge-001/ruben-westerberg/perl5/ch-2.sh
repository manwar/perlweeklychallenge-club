#!/usr/bin/env bash

perl -e 'print join ", ",map {my $o;$o="fizz" if $_ % 3 == 0; $o.="buzz" if $_ % 5 == 0; $o?$o:$_} (1..20)'
