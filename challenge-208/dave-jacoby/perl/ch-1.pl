#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min };

my @examples = (

    [ [qw{ Perl Raku Love}], [qw{Raku Perl Hate}], ],
    [ [qw{A B C}],           [qw{D E F}], ],
    [ [qw{A B C}],           [qw{C A B}], ],
);

for my $e (@examples) {
    my @o = min_index_sum( $e->@* );
    my $o = join ',',map { qq{"$_"} } @o;
    my $list1 = join ',',map { qq{"$_"} } $e->[0]->@*;
    my $list2 = join ',',map { qq{"$_"} } $e->[1]->@*;
    say <<"END";
    Input:  \@list1 = $list1
            \@list2 = $list2
    Output: ($o)
END
}

sub min_index_sum ( $list1, $list2 ) {
    my %output;
    for my $i ( 0 .. -1 + scalar $list1->@* ) {
        for my $j ( 0 .. -1 + scalar $list2->@* ) {
            next unless $list1->[$i] eq $list2->[$j];
            my $k = $i + $j;
            push $output{$k}->@*, $list1->[$i];
        }
    }
    my $min = min keys %output;
    return $output{$min}->@* if $min;
    return ();
}
