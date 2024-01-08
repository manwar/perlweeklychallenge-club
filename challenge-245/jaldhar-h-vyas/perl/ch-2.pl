#!/usr/bin/perl
use 5.030;
use warnings;

sub combinations {
    my @list = @{$_[0]};
    my $length = $_[1];

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

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

my $max = -1;

for my $elems (3 .. (scalar @ARGV)) {
    for my $combo (combinations(\@ARGV, $elems)) {
        my @permutations;
        permute { push @permutations, \@_; } @{$combo};
        for my $perm (grep { $_ % 3 == 0 } map { join q{}, @{$_} } @permutations) { 
            if ($perm > $max) {
                $max = $perm;
            }
        }
    }
}

say $max;
