#!/usr/bin/perl6

sub f($a, $b) {
    my $c = ($a+0).base(2);
    my $d = ($b+0).base(2);

    if ($c.chars > $d.chars) {
        $d = sprintf("%0*d", $c.chars, $d);
    } elsif ($d.chars > $c.chars) {
        $c = sprintf("%0*d", $d.chars, $c);
    }

    return ($c +^ $d ~~ m:g/ 1 /).elems;
}

sub MAIN(*@ARGS where { @*ARGS.elems > 0; }) {

    say [+] @*ARGS.combinations(2).map({ f(@_[0], @_[1]); });
 }