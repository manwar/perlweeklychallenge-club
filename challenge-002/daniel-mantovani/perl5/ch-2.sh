perl -E '$r=$r*35 + ($_ gt '9' ? -55 + ord : $_) for split "", shift;say $r' 'PERL5'

perl -E '$_=shift;while ($_) {unshift @m, $_ % 35;$_=int($_/35)};say map {$_>9?chr 55+$_:$_} @m' 38149690
