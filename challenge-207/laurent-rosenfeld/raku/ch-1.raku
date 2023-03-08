my @rows;
push @rows, %(map { $_ => True }, $_.comb)
    for "qwertyuiop", "asdfghjkl", "zxcvbnm";

sub find-kb-word (@in) {
    my @out;
    for @in -> $word {
        for @rows -> %row {
            push @out, $word and next
                if %row{all $word.lc.comb}:exists;
        }
    }
    return @out;
}
for <Hello Alaska Dad Peace>, <OMG Bye>,
    <Power Fad Finish Tower Quit True Omit> -> @test {
    say find-kb-word @test;
}
