#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use DateTime;

my @examples = (

    [qw{ Hello Alaska Dad Peace }],
    [qw{ OMG Bye }],
);

for my $e (@examples) {
    my $list  = join ',', map { qq{"$_"} } $e->@*;
    my $out   = keyboard_word( $e->@* );
    my $olist = join ',', map { qq{"$_"} } $out->@*;
    say <<"END";
    Input:  \@array = ($list)
    Output: ($olist)
END
}

sub keyboard_word ( @array ) {
    my @output;
    my %row_1 = map { $_ => 1 } split //, 'qwertyuiop';
    my %row_2 = map { $_ => 1 } split //, 'asdfghjkl';
    my %row_3 = map { $_ => 1 } split //, 'zxcvbnm';

    for my $Word (@array) {
        my $count;
        for my $l ( map { fc $_ } split //, $Word ) {
            $count->{1}++ if $row_1{$l};
            $count->{2}++ if $row_2{$l};
            $count->{3}++ if $row_3{$l};
        }
        push @output, $Word unless scalar keys $count->%* > 1;
    }
    return wantarray ? @output : \@output;
}

