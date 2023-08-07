#!//bin/sh

raku -e '@*ARGS.grep({my $a=$_.comb.sort.join;$_ ne $a && $_.flip ne $a}).elems.say' "$@"
