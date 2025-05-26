#!/usr/bin/raku

sub MAIN(
    Str $str,
    Int $i
) {
    my $dashless = $str.subst(q{-}, :g);
    my $pos = 0;
    my $len = $dashless.chars;
 
    my @segments = $dashless.substr($pos, $len % $i) || ();
    $pos += $len % $i;
 
    while $pos < $len {
        @segments.push($dashless.substr($pos, $i));
        $pos += $i;
    }
 
    @segments.join(q{-}).say;
}