#!/usr/bin/env perl
#
=head1 Task 2: Atoms Count

Submitted by: Mohammad Sajid Anwar

You are given a chemical formula with elements, numbers, and parentheses.
Write a script to count the total number of each type of atom by expanding all
grouped multipliers. Then, format and return the final inventory as a single
string sorted alphabetically by element name, including the total count only if
it is greater than 1.

=head2 Example 1

    Input: $formula = "((N2O)3(H2O)2)2"
    Output: "H8N12O10"

    Step 1: Expand the innermost parentheses
        (N2O)3 => N = 2*3 = 6, O = 1*3 = 3 => N6O3
        (H2O)2 => H = 2*2 = 4, O = 1*2 = 2 => H4O2

    Step 2: Combine inside the outer parentheses
        Formula becomes: (N6O3 H4O2)2
        Sum up identical elements inside: (N6 H4 O5)2

    Step 3: Apply the outer multiplier
        N = 6*2 = 12
        H = 4*2 = 8
        O = 5*2 = 10

    Step 4: Sort alphabetically and format
        Alphabetical order: H, N, O
        Counts: H: 8, N: 12, O: 10

=head2 Example 2

    Input: $formula = "Mg3(PO4)2"
    Output: "Mg3O8P2"

    Step 1: Parse ungrouped elements
        Mg3 => Mg = 3

    Step 2: Expand parentheses (PO4)2
        P = 1*2 = 2
        O = 4*2 = 8

    Step 3: Total up counts
        Mg = 3
        P  = 2
        O  = 8

    Step 4: Sort alphabetically and format
        Alphabetical order: Mg, O, P
        Counts: Mg: 3, O: 8, P: 2

=head2 Example 3

    Input: $formula = "(((H)2)3)4"
    Output: "H24"

    Step 1: Expand innermost level (H)2
        H = 1*2 = 2 => formula becomes ((H2)3)4

    Step 2: Expand middle level (H2)3
        H = 2*3 = 6 => formula becomes (H6)4

    Step 3: Expand outer level (H6)4
        H = 6*4 = 24

    Step 4: Sort alphabetically and format
        Single element: H: 24

=head2 Example 4

    Input: $formula = "NaCl3(O2(S10)2)2Mg"
    Output: "Cl3MgNaO4S40"

    Step 1: Expand innermost parentheses (S10)2
        S = 10*2 = 20 => inner formula becomes => O2S20

    Step 2: Expand outer parentheses (O2S20)2
        O = 2*2  = 4
        S = 20*2 = 40

    Step 3: Combine all parts
        Ungrouped start: Na (Na = 1), Cl3 (Cl = 3)
        Expanded middle: O = 4, S = 40
        Ungrouped end: Mg (Mg = 1)

    Step 4: Sort alphabetically and format
        Alphabetical order: Cl (3), Mg (1), Na (1), O (4), S (40)
        Omit the number 1 for Mg and Na.

=head2 Example 5

    Input: $formula = "Z2Y3(X2W)2"
    Output: "W2X4Y3Z2"

    Step 1: Parse ungrouped elements
        Z2 => Z = 2
        Y3 => Y = 3

    Step 2: Expand parentheses (X2W)2
        X = 2*2 = 4
        W = 1*2 = 2

    Step 3: Total up counts
        W = 2, X = 4, Y = 3, Z = 2

    Step 4: Sort alphabetically and format
        Alphabetical order: W (2), X (4), Y (3), Z (2)

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {formula => "((N2O)3(H2O)2)2",    out => "H8N12O10",     name => "Example 1"},
    {formula => "Mg3(PO4)2",          out => "Mg3O8P2",      name => "Example 2"},
    {formula => "(((H)2)3)4",         out => "H24",          name => "Example 3"},
    {formula => "NaCl3(O2(S10)2)2Mg", out => "Cl3MgNaO4S40", name => "Example 4"},
    {formula => "Z2Y3(X2W)2",         out => "W2X4Y3Z2",     name => "Example 5"},
    {formula => "Z2Y(X2W)2",          out => "W2X4YZ2",      name => "Example 6"},
);

sub atoms_count
{
    my $formula = shift;

    $formula =~ s/([A-Z][a-z]?)(\d+)/$1x$2/eg;
    $formula =~ s/\)(?!\d)/\)1/g;
    while ($formula =~ s/\(([^()]+)\)(\d+)/$1x$2/eg) {
        1;
    };
    my @elems = $formula =~ /([A-Z][a-z]?)/g;

    my %elems_cnt;
    ++$elems_cnt{$_} for @elems;

    my $atom_cnt;
    for my $e (sort keys %elems_cnt) {
        $atom_cnt .= $e . ($elems_cnt{$e} > 1 ? $elems_cnt{$e} : '');
    }

    return $atom_cnt;
}

for my $case (@cases) {
    my $got = atoms_count($case->{formula});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
