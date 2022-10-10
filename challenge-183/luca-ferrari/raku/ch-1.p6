#!raku

# Perl Weekly Challenge 183

sub MAIN() {
    my @list = [1,2], [3,4], [5,6], [1,2];
    my @clear;

    for 0 ..^ @list.elems -> $left {
        my $found = False;
        for $left ^..^ @list.elems -> $right {
            $found = True and last if @list[ $left ] ~~ @list[ $right ];
        }

        next if $found;
        @clear.push: @list[ $left ] if ! $found;
    }

    @clear.join( ',' ).gist.say;
}
