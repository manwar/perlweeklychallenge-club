#!/usr/bin/raku

sub findHighest(*@numbers) {
    my $highestScore = 0;
    for 0 .. @numbers.end -> $i {
        my $results = removeConsecutive($i, @numbers);
        my $points = $results.key;
        my @newNumbers = $results.value;
        my $score = $points + findHighest(@newNumbers);
        if ($score > $highestScore) {
            $highestScore = $score;
        }
   }
   return $highestScore;
}

sub removeConsecutive($i, *@numbers) {
    my $current = @numbers[$i];
    my $quantity = 0;

    for $i ..^ @numbers.elems -> $n {
        if @numbers[$n] != $current {
            last;
        } else {
            $quantity++;
        }
    }

    @numbers.splice($i, $quantity);

    return $quantity * $quantity => @numbers;
}

sub MAIN(
    *@numbers
) {
    say findHighest(@numbers);
}


