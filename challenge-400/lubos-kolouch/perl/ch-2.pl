#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=head1 NAME

ch-2.pl - Minimum Genetic Mutation

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 400, Task 2: Minimum Genetic Mutation.
Finds the minimum number of single-character mutations needed to transform
C<$start_gene> into C<$end_gene> using only valid intermediate genes in
C<$gene_bank>, or returns C<-1> if no path exists.

=head1 FUNCTIONS

=head2 min_genetic_mutation($start_gene, $end_gene, $gene_bank)

Performs breadth-first search from C<$start_gene> to C<$end_gene> over
C<$gene_bank> and returns the minimum mutation count, or C<-1> if unreachable.

=cut

signature_for min_genetic_mutation => (
    method     => 0,
    positional => [ Str, Str, ArrayRef [Str] ],
);

sub min_genetic_mutation ( $start_gene, $end_gene, $gene_bank ) {
    return 0 if $start_gene eq $end_gene;

    my %bank = map { $_ => 1 } @{$gene_bank};
    return -1 if !$bank{$end_gene};

    my @queue   = ( [ $start_gene, 0 ] );
    my %visited = ( $start_gene => 1 );
    my @bases   = qw(A C G T);

    while (@queue) {
        my ( $gene, $steps ) = @{ shift @queue };

        for my $pos ( 0 .. length($gene) - 1 ) {
            my $orig = substr $gene, $pos, 1;
            for my $base (@bases) {
                next if $base eq $orig;
                my $next_gene = $gene;
                substr $next_gene, $pos, 1, $base;

                return $steps + 1 if $next_gene eq $end_gene;

                if ( $bank{$next_gene} && !$visited{$next_gene} ) {
                    $visited{$next_gene} = 1;
                    push @queue, [ $next_gene, $steps + 1 ];
                }
            }
        }
    }

    return -1;
}

is(
    min_genetic_mutation( 'AACCGGTT', 'AACCGGTA', [ 'AACCGCTA', 'AAACGGTA' ] ),
    -1,
    'Example 1'
);
is(
    min_genetic_mutation( 'AACCGGTT', 'AACCGGAA', [ 'AACCGGTA', 'AACCGGAA', 'AACCGCTA', 'AACCCTAA', 'AACCGTAA' ] ),
    2,
    'Example 2'
);
is(
    min_genetic_mutation( 'AAAAAAAA', 'AAAAACCC', [ 'CAAAAAAA', 'CCAAAAAA', 'AAAAAAAC' ] ),
    -1,
    'Example 3'
);
is(
    min_genetic_mutation(
        'GAAAAAAA', 'GCCCCCCC',
        [ 'GCAAAAAA', 'GCCAAAAA', 'GCCCAAAA', 'GCCCCAAA', 'GCCCCCAA', 'GCCCCCCA', 'GCCCCCCC' ]
    ),
    7,
    'Example 4'
);
is(
    min_genetic_mutation( 'AACCGGTT', 'AACCGGTT', ['AACCGGTA'] ),
    0,
    'Example 5'
);
done_testing();
