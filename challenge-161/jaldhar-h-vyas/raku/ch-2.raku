#!/usr/bin/raku

sub makePangram(%wordlists, @completeOrder) {
    my @pangram = ();
    my @used;
    my @order = @completeOrder;
    my $count = 0;

    loop {
        my $letter = @order[0];
        my @choices = (| %wordlists{$letter}).sort({ $^b.chars <=> $^a.chars });
        my $word = q{};
        for @choices -> $choice {
            if $choice.comb ∩ @used == ∅ {
                $word = $choice;
                last;
            }
        }
        if $word eq q{} {
            $word = @choices[0];
        };
        @pangram.push($word);
        @used.push(| $word.comb);
        @order = @order.grep({ $_ ne @used.any; });
        $count += $word.chars;
        if @order.elems == 0 {
            last;
        }
    }

    return @pangram;
}

sub count(@pangram) {
    return [+] @pangram.map({ $_.chars});
}

sub MAIN() {
    my @words = "dictionary.txt".IO.lines;
    my %wordlists;

    for @words -> $word {
        my @letters = $word.comb;
        if $word eq @letters.sort.join && (@letters.categorize({ $_ })).values.all == 1 {
            for $word.comb -> $letter {
                %wordlists{$letter}.push($word);
            }
        }
    }

    my @order = %wordlists
        .keys
        .sort({ %wordlists{$^a}.elems <=> %wordlists{$^b}.elems });

    my @pangram = makePangram(%wordlists, @order);

    say "'", @pangram.join(q{ }), "' has ", count(@pangram), ' letters.';
}
