#! /usr/bin/raku

sub jumble($a) {
    my @p = $a.comb;
    return @p.pick(@p.elems).join('');
}

for lines() {
    .chomp;
    my $line = $_;
    $line ~~ s:g[(<[A..Za..z]>)(<[A..Za..z]><[A..Za..z]>+)(<[A..Za..z]>)] = $0 ~ jumble($1) ~ $2;
    say $line;
}
