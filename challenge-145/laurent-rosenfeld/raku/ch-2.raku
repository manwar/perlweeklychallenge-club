use v6;

sub is-palindrome (Str $in) { return $in eq $in.flip; }

sub find-all-palindromes ($input) {
    print "$input: ";
    my BagHash $seen;
    for 0..$input.chars -> $start {
        for 1..$input.chars - $start -> $length {
            my $candidate = substr $input, $start, $length;
            next unless is-palindrome $candidate.Str;
            next if $seen{$candidate};
            $seen{$candidate}++;
            print "$candidate ";
        }
    }
    say " ";
}

for <redivider deific rotors challenge
    champion christmas> ->  $test {
        find-all-palindromes $test;
}
