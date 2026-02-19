#!raku

#
# Perl Weekly Challenge 361
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-361>
#

sub MAIN() {
    my @party =
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
    ;

    # @party = [0, 0, 0, 0, 0],  # 0 knows NOBODY
    #          [1, 0, 0, 0, 0],  # 1 knows 0
    #          [1, 0, 0, 0, 0],  # 2 knows 0
    #          [1, 0, 0, 0, 0],  # 3 knows 0
    #          [1, 0, 0, 0, 0]   # 4 knows 0
    # ;

    my %known;
    my $required = @party.elems;

    for 0 ..^ @party.elems -> $current {
	my @who =  @party[ $current ].grep( * ~~ 1, :k );
	$required-- and next unless ( @who );
	%known{ $_ }++ for ( @who );
    }

    my @result = %known.keys.grep( { %known{ $_ } == $required } );
    @result.say and exit if ( @result );
    '-1'.say;
}
