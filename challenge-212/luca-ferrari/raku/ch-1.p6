#!raku

#
# Perl Weekly Challenge 212
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
#

sub MAIN( *@args ) {
    my $word = @args[ 0 ];
    my @jumps = @args[ 1 .. * ];
    my @alphabet = 'a' .. 'z';
    my @new-world;
    my $index = 0;
    for $word.lc.comb {
	next if ! $_;
	next if ! @alphabet.grep( * ~~ $_ );
	my $jump = @jumps.shift;
	my $idx = ( $jump + @alphabet.first( $_, :k ) ) % @alphabet.elems;
	@new-world.push: @alphabet[ $idx ];
    }

    @new-world.join.say;
}
