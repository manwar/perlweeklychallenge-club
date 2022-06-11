my @abecedarian =  'dictionary.txt'.IO.lines.grep({[le] .comb});
say (reverse sort {.chars}, @abecedarian)[0..25];
