use Test;

sub di-string-match(Str $str) {
    my $n = $str.chars;
    my ($low, $high) = 0, $n;
    my @perm;

    for $str.comb -> $char {
        @perm.push($char eq 'I' ?? $low++ !! $high--);
    }

    @perm.push($low);  # $low == $high at this point
    return @perm;
}

# Tests
is-deeply di-string-match("IDID"), [0, 4, 1, 3, 2], 'Test IDID';
is-deeply di-string-match("III"), [0, 1, 2, 3], 'Test III';
is-deeply di-string-match("DDI"), [3, 2, 0, 1], 'Test DDI';

done-testing;
