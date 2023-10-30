USING: kernel sequences ascii ;
IN: pwc-240-1
: ch-1 ( str seq -- t/f ) [ first ] "" map-as >lower = ;
"ppp" { "Perl" "Python" "Pascal" } ch-1 t assert=
"rp" { "Perl" "Raku" } ch-1 f assert=
"oac" { "Oracle" "Awk" "C" } ch-1 t assert=
