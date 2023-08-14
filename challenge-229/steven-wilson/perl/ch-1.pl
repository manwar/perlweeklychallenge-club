#!/usr/bin/env perl

use 5.12.0;
use Test2::V0;

my @ex1 = ( "abc", "bce", "cae" );
my @ex2 = ( "yxz", "cba", "mon" );
my @ex3 = ();
is( not_lexo_order( \@ex1 ), 1, "1 not in lexo order" );
is( not_lexo_order( \@ex2 ), 2, "2 not in lexo order" );
is( not_lexo_order( \@ex3 ), 0, "empty list" );
done_testing();

sub not_lexo_order {
    my @elements = @{ $_[0] };
    my @indices_to_delete;
    for ( 0 .. ( scalar @elements - 1 ) ) {
        my $elem            = $elements[$_];
        my $elem_sorted     = join '', sort split //, $elem;
        my $elem_rev_sorted = reverse $elem_sorted;
        if ( !( $elem eq $elem_sorted || $elem eq $elem_rev_sorted ) ) {
            push @indices_to_delete, $_;
        }
    }

    # Side effect.  Modifies @ex* outside function, otherwise don't see
    # the point of deleting if not returned.
    for ( reverse @indices_to_delete ) {
        splice @{ $_[0] }, $_, 1;
    }
    return scalar @indices_to_delete;
}
