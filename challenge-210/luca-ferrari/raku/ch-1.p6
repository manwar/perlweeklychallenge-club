#!raku

#
# Perl Weekly Challenge 210
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-210/>
#

sub MAIN( *@list is copy where { @list.grep( * ~~ Int).elems == @list.elems } ) {

    my @removed;

    for 2 .. @list.max {
	next if @removed.grep( * == $_ );
	next if @removed.grep( * == ( $_ + 1 ) );
	next if @removed.grep( * == ( $_ - 1 ) );
	@removed.push: @list.grep( * == $_ ), @list.grep( * == ( $_ + 1 ) ), @list.grep( * == ( $_ - 1 ) );
    }

    @removed.sum.say;
}

