#!/usr/bin/perl6

sub is_palindrome(Str $s) {
    return $s eq $s.flip;
}


sub get_palindromes(Str $s) {
    my @palindromes;

    for 2 .. $s.chars -> $l {
        my $possible = $s.substr(0, $l);
        if $possible.chars && is_palindrome($possible) {
            @palindromes.push($possible);
            @palindromes.push(get_palindromes($s.substr($l)));
        }
    }
    return @palindromes;
}

multi sub MAIN(
    Str $S  #= string to search for palindromes
) {
    my %results;

    for 0 ..^ $S.chars -> $n {
        for get_palindromes($S.substr($n)) -> $palindrome {
            if ($palindrome.trim ne q{}) {
                %results{$palindrome.trim}++;
            }
        }
    }
    say %results.keys.elems ?? %results.keys.join(q{, }) !! '-1';
}
