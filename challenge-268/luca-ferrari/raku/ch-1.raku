#!raku

#
# Perl Weekly Challenge 268
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
#

sub MAIN(  :@left,  :@right where { @left.elems == @right.elems }  ) {
    my @sorted-left  = @left.sort;
    my @sorted-right = @right.sort;

    my @diffs;
    for 0 ..^ @sorted-left.elems -> $i {
	my $current = @sorted-left[ $i ] - @sorted-right[ $i ];
	@diffs.push: $current if ! @diffs.grep( $current );
    }

    @diffs[ 0 ].say and exit  if @diffs.elems == 1;
    'Impossible'.say;
}
