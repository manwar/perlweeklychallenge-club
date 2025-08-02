#!raku

#
# Perl Weekly Challenge 253
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
#

sub MAIN() {

    my $matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
    ];

    my %ones;
    for 0 ..^ $matrix.elems -> $row_index {
	my $count = $matrix[ $row_index ].grep( * ~~ 1 ).elems;
	%ones{ $count }.push: $row_index;
    }


    my @rows.push: |%ones{ $_ }.sort for %ones.keys.sort;
    @rows.join( ', ').say;
}
