#!raku

#
# Perl Weekly Challenge 270
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
#

sub MAIN( Int $single,
	  Int $double,
	  *@nums is copy where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {

    my $current_max = @nums.max;
    my @need_operation = @nums.grep( * < $current_max, :k );
    my $score = 0;

    while ( @need_operation ) {

	if @need_operation.elems == 1 {
	    # single operation
	    @nums[ @need_operation[ 0 ] ] += 1;
	    $score += $single;
	}
	elsif @need_operation.elems > 1 {
	    @nums[ @need_operation[ 0 ] ] += 1;
	    @nums[ @need_operation[ 1 ] ] += 1;
	    $score += $double;
	}

	@need_operation = @nums.grep( * < $current_max, :k );
    }

    $score.say;

}
