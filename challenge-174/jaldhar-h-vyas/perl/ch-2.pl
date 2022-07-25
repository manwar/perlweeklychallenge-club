#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ smartmatch /;

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


sub permutation2rank {
    my ($args) = @_;
    my @perms;

    permute { push @perms, \@_; } sort @{$args};

    while (my ($index, $val) = each (@perms)) {
        if ($val ~~ $args) {
            return $index;
        }
    }

    return undef;
}

sub rank2permutation {
    my ($args, $rank) = @_;
    my @perms;

    permute { push @perms, \@_; } @{$args};

    return @{ $perms[$rank] };
}

say permutation2rank([1, 0, 2]);
say join q{, }, rank2permutation([0, 1, 2], 1);
