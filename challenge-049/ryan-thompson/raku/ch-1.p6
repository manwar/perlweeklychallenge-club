#!/usr/bin/env perl6
#
# ch-1.p6 - Smallest base-10 multiple of $n using only 1 and 0
#
# Ryan Thompson <rjt@cpan.org>

sub mult_bfs( Int \N ) {
    my $cur;
    loop (my (@r) = $cur = 1; $cur % N; $cur = @r.shift) {
        @r.push($cur ~ 0, $cur ~ 1)
    }
    $cur;
}

sub mult_fmt( Int \N ) { (1..∞).map( *.base(2) ).first( * %% N ) }

say mult_fmt($_) for 1..100;
