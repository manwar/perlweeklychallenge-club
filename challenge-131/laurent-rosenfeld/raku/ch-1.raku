use v6;

my @tests = [1, 2, 3, 6, 7, 8, 9],
            [11, 12, 14, 17, 18, 19],
            [2, 4, 6, 8],
            [1, 2, 3, 4, 5];
for @tests -> @input {
    my $prev = shift @input;
    my @result;
    my @tmp-res = $prev;
    for @input -> $i {
        if $i == $prev + 1 {
            push @tmp-res, $i;
        } else {
            push @result, [@tmp-res];
            @tmp-res = $i;
        }
        $prev = $i;
    }
    push @result, @tmp-res;
    say @result;
}
