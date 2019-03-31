use v6;

sub MAIN(Str :$string = 'Perl Weekly Challenge') {
        say $string.subst(:g, /e/, *.uc);
            say $/.elems;
}
