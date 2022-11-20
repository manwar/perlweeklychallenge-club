#!raku

# Perl Weekly Challenge 191

sub MAIN( *@l where { @l.grep( * ~~ Int ).elems == @l.elems } ) {
    my $max = @l.max;
    my @ll = @l.grep: { $_ == $max ||  $_ * 2 <= $max };
    '1'.say and exit if @ll.elems == @l.elems;
    '-1'.say;
}
