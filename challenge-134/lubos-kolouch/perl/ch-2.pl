use strict;
use warnings;
use feature qw/say/;

sub print_table_get_items {
    my ( $m, $n ) = @_;

    # TODO : proper formatting, counting of digits etc.
    # TODO : split to two functions, one function printing AND returning the items is ugly

    my %items;

    print "x | ";
    print "$_ " for ( 1 .. $m );
    say "";
    say "---------";

    for my $i ( 1 .. $n ) {
        print "$i | ";

        for my $j ( 1 .. $m ) {
            print $i * $j . " ";
            $items{ $i * $j } = 1;
        }
        say "";
    }

    return %items;
}

sub print_results_get_count {
    my $what = shift;

    # TODO : split to two functions, one function printing AND returning count is ugly

    print "Distinct counts: ";
    for my $key ( sort { $a <=> $b } keys %$what ) {
        print "$key ";
    }
    say "";

    return scalar keys %$what;
}

my %result     = print_table_get_items( 3, 3 );
my $elem_count = print_results_get_count( \%result );

use Test::More;
is( $elem_count, 6 );
done_testing;
