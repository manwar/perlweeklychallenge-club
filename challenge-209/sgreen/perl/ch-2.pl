#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Array::Utils qw(intersect unique);
use JSON;

sub group_lists ( $account, $group ) {
    my @rows = ();

  G: while ( $#$group != -1 ) {
        # Retrieve the first row
        my $addresses = shift @$group;

        # See if there is a match with other rows
        while ( my ( $i, $other ) = each @$group ) {
            if ( intersect( @$addresses, @$other ) ) {
                # There is, merge the rows and prepend them to the list
                splice( @$group, $i, 1 );
                unshift @$group, [ unique( @$addresses, @$other ) ];
                next G;
            }
        }

        # There isn't. Add this row to the rows list
        push @rows, [ $account, sort @$addresses ];
    }

    return @rows;
}

sub main ($array) {
    # Group the input by account, where the e-mails are sets
    my %groups = ();
    foreach my $row (@$array) {
        my $account = shift @$row;
        push @{ $groups{$account} }, $row;
    }

    # Turn each group into the final lists
    my @results = ();
    foreach my $account ( sort keys %groups ) {
        push @results, group_lists( $account, $groups{$account} );
    }

    my $j = JSON::XS->new->utf8->pretty(1);
    say $j->encode( \@results );
}
main( decode_json( $ARGV[0] ) );