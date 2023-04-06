use strict;
use warnings;

sub insert_operators {
    my ( $str, $target ) = @_;
    my @results;
    helper( $str, $target, "", \@results );
    return @results;
}

sub helper {
    my ( $str, $target, $expr, $results ) = @_;
    if ( $str eq "" ) {
        if ( eval($expr) == $target ) {
            push @$results, $expr;
        }
        return;
    }
    for my $i ( 1 .. length($str) ) {
        my $left  = substr( $str, 0, $i );
        my $right = substr( $str, $i );
        helper( $right, $target, "$expr+$left", $results );
        helper( $right, $target, "$expr-$left", $results );
    }
}

my @results = insert_operators( "123456789", 100 );
print "$_\n" for @results;
