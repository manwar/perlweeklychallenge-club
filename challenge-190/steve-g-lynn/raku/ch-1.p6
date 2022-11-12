#!/usr/bin/env perl6

say 'Perl:', &capital-detection('Perl');
say 'TPF:', &capital-detection('TPF');
say 'PyThon:', &capital-detection('PyThon');
say 'raku:', &capital-detection('raku');

sub capital-detection( Str $s) {
    ($s ~~ 
    /^ <[A .. Z]> ? <[ a .. z]> + $ || 
    ^ <[A .. Z]> + $ || 
    ^ <[a .. z]> +/) 
    ?? 1 
    !! 0;
}

