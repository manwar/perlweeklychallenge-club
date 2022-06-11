#!/usr/bin/raku

sub makePangram(%wordlists, @order) {
    my @pangram = ();
    my @used;

    loop {
        my $letter = @order[0];
        my @choices = (| %wordlists{$letter}).sort({ $^a.chars <=> $^b.chars });
        my $word = q{};

        my $best = 26;
        for @choices -> $choice {
            my $matches = ($choice.comb ∩ @used).elems; 
            if  $matches <= $best {
                $best = $matches;
                $word = $choice;
            }
        }

        @pangram.push($word);
        @used.push(| $word.comb);
        @order = @order.grep({ $_ ne @used.any; });
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
            for @letters -> $letter {
                %wordlists{$letter}.push($word);
            }
        }
    }

    my @order = ('a' .. 'z').sort({ %wordlists{$^a}.elems <=> %wordlists{$^b}.elems });

    my @pangram = makePangram(%wordlists, @order);

    say "'", @pangram.join(q{ }), "' has ", count(@pangram), ' letters.';
}
