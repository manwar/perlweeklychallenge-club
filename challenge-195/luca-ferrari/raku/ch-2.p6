#!raku

# Perl Weekly Challenge 195

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my $bag = @list.grep( * %% 2 ).Bag;
    my $most-frequency = $bag.values.max;
    my @most-frequent-evens;
    for $bag.keys {
	next if $bag{ $_ } != $most-frequency;
	@most-frequent-evens.push: $_;
    }

    @most-frequent-evens.min.say;
}
