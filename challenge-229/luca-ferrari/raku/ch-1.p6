#!raku

#
# Perl Weekly Challenge 229
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
#

sub MAIN( *@words is copy ) {
    my $deleted = 0;

    for 0 ..^ @words.elems {
	my $word = @words[ $_ ];
	@words[ $_ ]:delete and $deleted++ if $word ne $word.comb.sort.join;
    }

    $deleted.say;
}
