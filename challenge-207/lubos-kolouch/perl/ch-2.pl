#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Test::More;

=head1 NAME

h_index - computes the researcher’s H-Index

=head1 SYNOPSIS

  use strict;
  use warnings;
  use feature 'say';

  my @citations = (10, 8, 5, 4, 3);
  my $h_index = h_index(@citations);
  say "H-Index: $h_index";

=head1 DESCRIPTION

The H-Index is the largest number h such that h articles have at least h citations each.
This function takes an array of integers containing citations a researcher has received
for each paper and computes the researcher’s H-Index.

=head1 EXAMPLES

  # Example 1
  my @citations_1 = (10, 8, 5, 4, 3);
  my $h_index_1 = h_index(@citations_1);
  say "Example 1: expected 4, got $h_index_1";
  is($h_index_1, 4, "Test Example 1");

  # Example 2
  my @citations_2 = (25, 8, 5, 3, 3);
  my $h_index_2 = h_index(@citations_2);
  say "Example 2: expected 3, got $h_index_2";
  is($h_index_2, 3, "Test Example 2");

=cut

sub h_index {
    my @citations        = @_;
    my $n                = scalar @citations;
    my $h                = 0;
    my @sorted_citations = sort { $b <=> $a } @citations;

    for ( my $i = 0 ; $i < $n ; $i++ ) {
        if ( $sorted_citations[$i] >= $i + 1 ) {
            $h = $i + 1;
        }
        else {
            last;
        }
    }
    return $h;
}

# Run the tests
my @citations_1 = ( 10, 8, 5, 4, 3 );
my $h_index_1   = h_index(@citations_1);
is( $h_index_1, 4, "Test Example 1" );

my @citations_2 = ( 25, 8, 5, 3, 3 );
my $h_index_2   = h_index(@citations_2);
is( $h_index_2, 3, "Test Example 2" );

done_testing();
