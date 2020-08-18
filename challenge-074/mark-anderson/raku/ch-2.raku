sub MAIN($string) {
    my @fnr-chars = gather {
        for 1..$string.chars -> $i {
            take fnr($string.substr($i-1, 1));
        }
    }

    say @fnr-chars.join;
}

sub fnr($letter) {
    state %seen;
    state $fnr-chars;

    %seen{$letter}++;

    given %seen{$letter} {
        when 1 {
            $fnr-chars ~= $letter;
            return $letter;
        }
        when 2 {
            my $idx = $fnr-chars.index($letter);
            $fnr-chars = $fnr-chars.substr(0, $idx) ~ $fnr-chars.substr($idx+1);
        }
    }

    return $fnr-chars.substr($fnr-chars.chars-1, 1) // "#";
}
