use v6;

constant %tile-values =
    A => 1, B => 4, C => 5, D => 3, E => 2,
    F => 3, G => 1, H => 5, I => 1, J => 2,
    K => 10, L => 2, M => 5, N => 4, O => 5,
    P => 3, Q => 10, R => 2, S => 1, T => 5,
    U => 1, V => 2, W => 3, X => 1, Y => 2, Z => 1;

constant %tile-count =
    A => 8, B => 5, C => 4, D => 3, E => 9,
    F => 3, G => 3, H => 3, I => 5, J => 3,
    K => 2, L => 3, M => 4, N => 4, O => 3,
    P => 5, Q => 2, R => 3, S => 7, T => 5,
    U => 5, V => 3, W => 5, X => 2, Y => 5, Z => 5;

my $tile-bag = (map {$_ xx %tile-count{$_}}, keys %tile-count).Bag;

sub MAIN (Int $count = 7) {
    my %word-list;
    for "words.txt".IO.lines -> $line {
        next if $line.chars > $count;
        my $ordered = $line.uc.comb.sort.join("");
        my $line-value = [+] $ordered.comb.map({%tile-values{$_}});
        %word-list{$ordered}<word> = $line;
        # Note we will keep only one word for anagrams, but
        # that's OK since anagrams have the same value
        %word-list{$ordered}<value> = $line-value;
    }
    for 1..10 {
        my @picked-tiles = $tile-bag.pick($count);
        my $max-combination = "";
        my $max-value = 0;
        for @picked-tiles.combinations -> $candidate {
            my $ordered = $candidate.sort.join("");
            next unless %word-list{$ordered}:exists;
            if %word-list{$ordered}<value> > $max-value {
                $max-value = %word-list{$ordered}<value>;
                $max-combination = $ordered;
            }
        }
        say "The best candidate for list ", @picked-tiles.join(""), " is:";
        say "    No word found!" and next unless $max-value;
        say "    %word-list{$max-combination}<word> (score: $max-value)";
    }
}
