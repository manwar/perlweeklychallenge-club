#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Compare;
use JSON;
my $json = JSON->new->pretty;

my @examples = (

    [
        [ 'A', 'a1@a.com', 'a2@a.com' ],
        [ 'B', 'b1@b.com' ],
        [ 'A', 'a3@a.com', 'a1@a.com' ]
    ],
    [
        [ 'A', 'a1@a.com', 'a2@a.com' ],
        [ 'B', 'b1@b.com' ],
        [ 'A', 'a3@a.com' ],
        [ 'B', 'b2@b.com', 'b1@b.com' ]
    ],
);

for my $e (@examples) {
    my $i = format_mailbox( $e->@* );
    my @o = merge_mailbox( $e->@* );
    my $o = format_mailbox(@o);
    say <<"END";
    Input:  \@accounts = 
      $i
    Output: 
      $o
END
    say '';
}

# yes, a more complex version of JSON->encode
sub format_mailbox (@accounts) {
    @accounts = sort { $a->[0] cmp $b->[0] } @accounts;
    my $output = join ",\n\t", map { qq{[$_]} }
        map {
        join ',',
            map { qq{"$_"} }
            $_->@*
        } @accounts;
    $output = join ' ', '[', $output, ']';
    return $output;
}

sub merge_mailbox (@input) {
    my @accounts = @input;
    for my $i ( 0 .. -2 + scalar @accounts ) {
        my $ai = $accounts[$i];
        my @ii = $ai->@*;
        shift @ii;
        for my $j ( $i + 1 .. -1 + scalar @accounts ) {
            my $aj = $accounts[$j];
            next unless defined $aj;
            my @jj = $aj->@*;
            shift @jj;
            my $lc    = List::Compare->new( \@ii, \@jj );
            my @inter = $lc->get_intersection;
            if ( scalar @inter ) {
                my @union = $lc->get_union;
                my $ni    = $ai->[0];
                $ai->@* = ( $ni, @union );
                $aj->@* = ();
            }
        }
    }
    @accounts = sort { $a->[0] cmp $b->[0] } grep { scalar $_->@* } @accounts;
    return @accounts;
}
