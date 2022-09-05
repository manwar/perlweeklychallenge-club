#! /usr/bin/raku

saywrap(reorder("
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
"));

sub reorder($para0) {
    my $para = $para0.trim;
    $para ~~ s:g/\n/ /;
    $para ~~ s:g/\s{2..*}/ /;
    my @o;
    for $para.split(/<[.?!]> /) -> $s0 {
        if ($s0) {
            my $s = $s0;
            $s ~~ s:g:i/<-[a..z]>\s/ /;
            $s ~~ s:g/\.$//;
            $s = $s.trim;
            $s ~~ s:g/\s{2..*}/ /;
            my @w = $s.split(' ').sort: {lc($^a) cmp lc($^b)};
            push @o,@w.join(' ') ~ '.';
        }
    }
    return @o.join(' ');
}

sub saywrap($p0) {
    my $p = $p0;
    my $ll = 72;
    while ($p.chars >= $ll) {
        my $c = $ll;
        while ($c > 0) {
            if (substr($p, $c, 1) eq ' ') {
                say substr($p, 0, $c);
                $p = substr($p, $c+1);
                $c = -1;
                last;
            }
            $c--;
        }
        if ($c == 0) {
            say substr($p, 0, $ll-1) ~ '-';
            $p = substr($p, $ll);
        }
    }
    if ($p.chars > 0) {
        say $p;
        }
}
