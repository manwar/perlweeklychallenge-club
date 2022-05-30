for "words.txt".IO.lines -> $line {
    next unless 2 <= $line.chars <= 8;
    next if $line ~~ /<-[a..f olist]>/;
    say "$_ -> 0x", TR/olist/01157/ with $line;
}
