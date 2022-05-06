#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use List::Util qw{sum0};

my @n = @ARGV;
@n = ( 1, 2, 3 ) unless scalar @n;
my @pairs = get_pairs(@n);
my $n     = join ' ', @n;
my $sum   = sum0 map { $_->[0] & $_->[1] } @pairs;
say <<"END";
    Input:  ($n)
    Output: $sum
END
exit;

sub get_pairs( @array ) {
    my $p = Algorithm::Permute->new( \@array, 2 );
    my @output;
    my %x;
    while ( my @pair = $p->next ) {
        @pair = sort @pair;
        next if $x{ join ',', @pair }++;
        push @output, [@pair];
    }
    return @output;
}
