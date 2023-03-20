use strict;
use warnings;
use feature "say";

sub min_sum_idx {
    my @s1 = @{$_[0]};
    my @s2 = @{$_[1]};

    my %h1 = map {$s1[$_] => $_ } 0..$#s1;
    my %h2 = map {$s2[$_] => $_ } 0..$#s2;
    my @result = grep { exists $h1{$_} } @s2;
    return "()" unless @result;
    my %res = map { $_ => $h1{$_} + $h2{$_} } @result;
    my $min = $res{$result[0]};
    for my $k (keys %res) {
        $min = $res{$k} if $res{$k} < $min;
    }
    return grep {$res{$_} == $min} @result;
}

for my $test ( [[<Perl Raku Love>], [<Raku Perl Hate>]],
    [[<A B C>], [<D E F>]], [[<A B C>], [<C A B>]] ) {

    printf "%-14s - %-16s => ",
        "@{$test->[0]}", "@{$test->[1]}";
    say join " ", min_sum_idx @$test;
}
