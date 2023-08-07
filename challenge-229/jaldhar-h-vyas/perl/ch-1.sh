#!//bin/sh

perl -E 'say scalar grep{my $x=join q{},sort split //;$_ ne $x && reverse ne $x}@ARGV' "$@"
