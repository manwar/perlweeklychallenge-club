use strict;
use warnings;
use feature "say";
use Data::Dumper;


my @tests = ( [ [ 0..3 ], [ (4..7) ],  [ (8..11) ],  [ (12..15) ] ],
              [ [ 0..4 ], [ (5..9) ],  [ (10..14) ], [ (15..19) ] ],
              [ [ 0..5 ], [ (6..11) ], [ (12..17) ], [ (18..23) ] ],
              [ [ 0..5 ], [ (6..11) ], [ (12..17) ] ],
              [ [ 0..2 ], [ (4..6) ],  [ (8..10) ],  [ (12..14) ] ]
            );

# @tests = ( [ [ 0..3 ], [ (4..7) ],  [ (8..11) ],  [ (12..15) ] ] );

sub print_matrix {
    my @matrix = @{$_[0]};
    say "";
    say "[ ", (map { sprintf "% 3i", $_ } @$_), " ]" for @matrix;
    say "";
}

for my $m_ref (@tests) {
    print_matrix($m_ref);
    my @result;
    my @matrix = @$m_ref;
    while (1) {
        push @result, @{shift @matrix};
        last if scalar @matrix == 0;
        push @result, pop @{$matrix[$_]} for 0..$#matrix;
        push @result, reverse @{pop @matrix};
        push @result, shift @{$matrix[$_]} for reverse 0..$#matrix;
        last if @matrix == 0;
    }
    say join " ", @result;
}
