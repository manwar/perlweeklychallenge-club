#!raku

#
# Perl Weekly Challenge 350
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-350>
#

sub MAIN( Str $string, Int $size = 3 ) {

    my @chars = $string.comb;
    my @good-substrings;

    for 0 .. @chars.elems - $size -> $index {
	my $current = Bag.new: @chars[ $index ..^ $index + $size ];
	next if $current.values.grep( * > 1 );
	@good-substrings.push: $current.keys.join;
    }

    @good-substrings.elems.say;
}
