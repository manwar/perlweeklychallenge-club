sub MAIN (Int $limit = 4) {
    for "words.txt".IO.lines -> $line {
        next unless 2 <= $line.chars <= 8;
        next if $line ~~ /<-[a..f olist]>/;
        my $word = $line;
        my $dist =  +tr/olist/01157/ for $word;
        say "$line -> 0x", $word if $dist <= $limit
    }
}
