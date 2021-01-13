#!/user/bin/env raku

sub solve ($S){
    # split into words
    my @words = $S.split(/\s+/);

    # remove the first and the last words
    @words.pop;
    @words.shift;

    # add the lengths of the remaining words.
    [+] @words.map(*.Str.chars);
}


sub MAIN(Str :$S){
    say solve("The Weekly Challenge");
    say solve("The purpose of our lives is to be happy");
}
