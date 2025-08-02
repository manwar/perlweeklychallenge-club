#!raku

#
# Perl Weekly Challenge 308
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-308>
#

sub MAIN(  :@arr, :$initial  ) {

    my @result = $initial;
    for 1 .. @arr -> $index {
	@result.push: @result[ * - 1 ] +^ @arr[ $index - 1 ];
    }

    @result.say;
}
