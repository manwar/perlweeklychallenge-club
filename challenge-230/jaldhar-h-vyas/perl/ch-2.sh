#!//bin/sh

perl -E '$p=shift;say scalar grep{/^$p/}@ARGV' "$@"
