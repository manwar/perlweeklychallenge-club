use v6;

sub MAIN (Str $str1, Str $str2) {
    my $letters = $str1.comb.grep( /<[A..Za..z]>/ ).Set;
    my $count = $str2.comb.grep( { $_ (elem) $letters} ).elems;
    say "$str2 has $count letters from $str1";
}
