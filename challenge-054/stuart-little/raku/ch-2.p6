#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
my %cllens = (1 => 1);

sub cltz($n) { ($n %% 2) ?? ($n div 2) !! (($n > 1) ?? (3*$n+1) !! (1)) }

sub cllen($n) {
    %cllens{$n} //= 1+cllen($n.&cltz)
}

sub cltz_seq(Int $n where * > 0) {
    given $n {
	when 1 { (1,) }
	when * %% 2 { ($n,|cltz_seq($n div 2)) }
	default { ($n,|cltz_seq(3*$n+1)) }
    }
}

multi sub MAIN(
    Bool :b(:$bonus),
) {
    my $L=1_000_000;
    my $wndw=20;
    my @maxn=[1];

    for (1..$L) {
	my $ln = cllen($_);
	($ln > %cllens{@maxn}.max) && do {
	    (@maxn.elems == $wndw) && @maxn.shift;
	    @maxn.push($_)
	}	
    }

    for @maxn {
	say $_ ~ " " ~ %cllens{$_}
    }
}

multi sub MAIN(
    *@ARGS,
) {
    say @ARGS[0].Int.&cltz_seq;
}
