#!/usr/bin/raku

sub MAIN(
    Str $str
) {
    my @reversed = $str.comb.grep({ /<alpha>/ }).reverse;
    my $index = 0;

    ($str.subst(/<alpha>/, { @reversed[$index++] }, :g)).say;
}
