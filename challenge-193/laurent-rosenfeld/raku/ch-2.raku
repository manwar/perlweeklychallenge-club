my %transco = ("a".."z" Z 0..25).flat; # a => 0, b => 1 ...

sub diff-array ($str) {
    my @diff;
    for 1..^$str.chars -> $i {
        push @diff,
            %transco{substr($str, $i, 1)}
            - %transco{substr($str, $i-1, 1)};
    }
    return @diff;
}

for <adc wzy abc>, <aaa bob ccc ddd> -> @test {
    my %result;
    for @test -> $st {
        push %result, (diff-array $st) => $st;
    }
    # say %result;
    for %result.keys -> $k {
        say @test, " -> ", %result{$k} if %result{$k}.elems == 1;
    }
}
