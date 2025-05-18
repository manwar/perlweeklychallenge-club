#!/usr/bin/raku

sub MAIN(
    Str $str1,
    Str $str2
) {
    my $copy1 = $str1;
    my $copy2 = $str2;

    $copy1 = $copy1.subst(/<-[#]> '#' /) while $copy1 ~~ /<-[#]> '#' /;
    $copy2 = $copy2.subst(/<-[#]> '#' /) while $copy2 ~~ /<-[#]> '#' /;
 
    say $copy1 eq $copy2;
}