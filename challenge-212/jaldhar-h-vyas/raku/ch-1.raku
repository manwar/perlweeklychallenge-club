#!/usr/bin/raku

sub MAIN(
    $word,
    *@jump
) {
    my @letters = $word.comb;
    for 0 .. @letters.end -> $i {
        my $aord =  @letters[$i] ~~ /<upper>/ ?? 'A'.ord !! 'a'.ord; 
        @letters[$i] = 
          ((((@letters[$i].ord - $aord) + @jump[$i]) % 26) + $aord).chr;
    }

    say @letters.join;
}