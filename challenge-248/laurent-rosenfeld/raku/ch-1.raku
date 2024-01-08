sub shortest-distance ($char, $str) {
    my @result;
    for 0..^$str.chars -> $i {
        my $next = $str.index($char, $i);
        my $prev = $str.rindex($char, $i);
        push @result, abs($i - $next) and next
            unless defined $prev;
        push @result, abs($i - $prev) and next
            unless defined $next;
        my $dist = abs($i - $next) < abs($i - $prev) ??
                   abs($i - $next) !! abs($i - $prev);
        push @result, $dist;
    }
    return "@result[]";
}

my @tests = { str => "loveleetcode", char => "e" },
            { str => "aaab", char => "b"};
for @tests -> %test {
    printf "%-1s - %-15s => ", %test{"char"}, %test{"str"};
    say shortest-distance %test{"char"}, %test{"str"};
}
