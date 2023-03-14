#!/usr/bin/perl
use 5.030;
use warnings;

sub batch {
    my @range = @{$_[0]};
    my $quantity = $_[1];

    if ($quantity < 1 || $quantity > scalar @range) {
        die "out of range\n";
    }

    my $length = scalar @range;
    my $i = 0;
    while ($i < $length) {
        my @row;
        for (1 .. $quantity) {
            push @row, shift @range;
            $i++;
            if ($i == $length) {
                last;
            }
        }
        push @range, [@row];
    }

    return wantarray ? @range : $range[0];
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

sub unique {
  my %seen;
  for my $elem (@_) {
    $seen{$elem}++;
  }
  return keys %seen;
}

sub min {
    return $_[0] < $_[1] ? $_[0] : $_[1];
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my @permutations;
permute { push @permutations, \@_; } @ARGV;

say [
    sort { $b <=> $a }
    map { sum([map { min(@{$_}) } @{$_}]) }
    map { [batch($_, 2)] }
    map { [ split // ] }
    unique(
        map { join q{}, @{$_} }
        map { [map { sort { $a <=> $b } @{$_} } @{$_}] }
        map { [batch($_, 2)] }
        grep { $_->[0] == $ARGV[0] }
        @permutations
    )
]->[0];
