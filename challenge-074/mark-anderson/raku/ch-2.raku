unit sub MAIN($string);

my %seen;
my $singles;

my @first-non-repeatings = gather {
    for 1..$string.chars -> $i {
        my $letter = $string.substr($i-1, 1);    

        %seen{$letter}++;

        if %seen{$letter} == 1 {
            $singles ~= $letter;
            take $letter;
        }

        else {
            my $idx = $singles.index($letter);
            $singles = $singles.substr(0, $idx) ~ $singles.substr($idx+1);
            take $singles.substr($singles.chars-1, 1) // "#";
        }
    }
}

say @first-non-repeatings.join;
