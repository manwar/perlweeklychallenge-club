use v6;

my @fusc = 0, 1;
for 2..49 -> $i {
    @fusc[$i] = $i %% 2 ?? @fusc[$i/2] !!
        @fusc[($i-1)/2] + @fusc[($i+1)/2];
}
say @fusc.join: " ";
