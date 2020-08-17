sub MAIN($string) {
    my @fnr-chars = gather {
        for 1..$string.chars -> $i {
            take fnr($string.substr(0, $i));
        }
    }

    say @fnr-chars.join;
}

sub fnr($string) {
    state %seen;
    state $singles;

    my $letter = $string.substr($string.chars-1, 1);    

    %seen{$letter}++;

    given %seen{$letter} {
        when 1 {
            $singles ~= $letter;
            return $letter;
        }
        when 2 {
            my $idx = $singles.index($letter);
            $singles = $singles.substr(0, $idx) ~ $singles.substr($idx+1);
        }
    }

    return $singles.substr($singles.chars-1, 1) // "#";
}
