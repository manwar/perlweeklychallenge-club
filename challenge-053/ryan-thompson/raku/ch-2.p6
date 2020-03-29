#!/usr/bin/env perl6

# ch-2.p6 - Vowel Strings
#
# Ryan Thompson <rjt@cpan.org>

#| Graph edges. Key = current node, values => reachable nodes
my %edges = :a<e i>, :e<i>, :i<a e o u>, :o<a u>, :u<o e>;

#| Builds vowel strings using BFS with queue
sub vowel-string-iter( Int $len where $len > 0 ) {
    my @queue = %edges.keys.sort;
    sub {
        while (my $str = @queue.shift) {
            return $str if $str.chars ≥ $len;
            @queue.push: |$str «~« %edges{ $str.substr(*-1) };
        }
    }
}

#| Print all vowel strings for the specified length
sub MAIN( Int $len where { $len > 0 } = 3 ) {
    my $it = vowel-string-iter( $len );
    .say while $_ = $it.();
}
