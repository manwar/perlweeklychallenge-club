#!/usr/bin/perl
use 5.030;
use warnings;

sub permute (&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}
my @n = @ARGV;

my $maximum = -Inf;
my @maxima;
my @perms;

permute { push @perms, \@_; } @n;

for my $combo (map { [@$_[0..2] ]; } @perms) {
    my ($a, $b, $c) = @{$combo};
    if (($a + $b > $c) && ($b + $c > $a) && ($a + $c > $b)) {
        if (($a + $b + $c) > $maximum) {
            @maxima = ();
        }
        if (($a + $b + $c) >= $maximum) {
            $maximum = $a + $b + $c;
            push @maxima, [$a, $b, $c];
        }
    }
}

if (scalar @maxima == 0) {
    say '()';
} else {
    if (scalar @maxima > 1) {
        @maxima = grep{ $_->[0] >= $_->[1] && $_->[1] >= $_->[2]; } @maxima;
    }
    say q{(}, (join q{, }, @{$maxima[0]}), q{)};
}
