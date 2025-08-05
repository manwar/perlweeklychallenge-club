use v5.36;

sub dupz(@v) {
    my @r = map $_ || (0, 0), @v;
    splice @r, @v;
    @r
}

sub dupz2(@v) {
    my @r;
    for my $v (@v) {
        for my $x ($v || (0, 0)) {
            push @r, $x;
            return @r if @r >= @v;
        }
    }
}

for my $input (
    [1, 0, 2, 3, 0, 4, 5, 0],
    [1, 2, 3],
    [1, 2, 3, 0],
    [0, 0, 1, 2],
    [1, 2, 0, 3, 4],
) {
    my @result = dupz @$input;
    my @result2 = dupz2 @$input;
    say "(@$input)";
    say "a: (@result)";
    say "b: (@result2)";
    say "";
}
