#!/usr/bin/env raku

use v6.d;

sub get-duplicates(Str @strings1, Str @strings2 --> List) {
    (Set(@strings1) (&) Set(@strings2)).keys.List;
}

sub invert-kv(Str @strings --> Hash) {
    (@strings.values Z=> @strings.keys).Hash;
}

sub index-sum(Str @strings1, Str @strings2 --> Seq) {
    my %invert1 = invert-kv(@strings1);
    my %invert2 = invert-kv(@strings2);
    my @duplicates = get-duplicates(@strings1, @strings2);
    map({ ($_, %invert1{$_} + %invert2{$_})}, @duplicates);
}

sub minimum-index-sum(Str @strings1, Str @strings2 --> Seq) {
    my @pairs = index-sum(@strings1, @strings2);
    my $min-index = min(map({ $_[1] }, @pairs));
    map({ $_[0] }, grep({ $_[1] == $min-index }, @pairs));
}

#| Run test cases
sub MAIN() {
    use Test;
    plan 3;

    is minimum-index-sum(Array[Str].new(['Perl', 'Raku', 'Love']),
        Array[Str].new(['Raku', 'Perl', 'Love'])).sort,
        ('Perl', 'Raku'),
        "works for ('Perl', 'Raku')";
    is minimum-index-sum(Array[Str].new(['A', 'B', 'C']),
        Array[Str].new(['D', 'E', 'F'])),
        (),
        'works for ()';
    is minimum-index-sum(Array[Str].new(['A', 'B', 'C']),
        Array[Str].new(['C', 'A', 'B'])),
        ('A'),
        'works for ("A")';
}
