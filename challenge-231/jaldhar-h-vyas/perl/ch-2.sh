#!//bin/sh

perl -E 'say scalar grep {$_>=60} map {/.{11}(..)/} @ARGV' "$@"