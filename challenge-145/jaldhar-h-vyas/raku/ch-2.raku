#!/usr/bin/raku

sub isPalindrome(Str $word) {
    return $word eq $word.flip;
}

sub MAIN(
    Str $s
) {
    my @palindromes;

    for 0 ..^ $s.chars -> $i {
        if $s.substr($i, 1) ne @palindromes.any  {
            @palindromes.push($s.substr($i, 1));
        }

        my $distance = $s.chars - $i;
        while $distance > 1 {
            my $part = $s.substr($i, $distance);
            if isPalindrome($part) && $part ne @palindromes.any {
                @palindromes.push($part);
                last;
            } else {
                $distance--;
            }
        }
    }

    say @palindromes.join(q{ });
}