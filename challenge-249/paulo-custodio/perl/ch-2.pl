#!/usr/bin/env perl

use Modern::Perl;

my @permutation = find_permutation(@ARGV);
say "(", join(", ", @permutation), ")";

sub find_permutation {
    my($s) = @_;
    my @s = split //, $s;
    my @n = (0 .. length($s));
    my @permutations = permutations(@n);
    for (@permutations) {
        my @permutation = @$_;
        if (check_permutation(\@s, \@permutation)) {
            return @permutation;
        }
    }
    return ();
}

sub check_permutation {
    my($s, $permutation) = @_;
    my @s = @$s;
    my @permutation = @$permutation;

    for my $i (0 .. $#permutation-1) {
        if (!($s[$i] eq 'I' && $permutation[$i] < $permutation[$i+1] ||
              $s[$i] eq 'D' && $permutation[$i] > $permutation[$i+1])) {
            return 0;
        }
    }
    return 1;
}

sub permutations {
    my(@items) = @_;

    # Base case: no items - one empty permutation
    return [] if @items == 0;

    my @result;

    for my $i (0 .. $#items) {
        my $item = $items[$i];

        # Remaining items after removing index $i
        my @rest = @items[0 .. $i-1, $i+1 .. $#items];

        # Recursively permute the rest
        for my $perm_ref (permutations(@rest)) {
            push @result, [$item, @$perm_ref];
        }
    }

    return @result;
}
