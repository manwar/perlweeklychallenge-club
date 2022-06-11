#!/usr/bin/raku

sub MAIN() {
    my @pernicious;
    my $count = 2;

    while @pernicious.elems < 10 {
        if $count.base(2).comb.grep({ $_ eq '1'; }).elems.is-prime {
            @pernicious.push($count);
        }
        $count++;
    }

    @pernicious.join(q{, }).say;
}
