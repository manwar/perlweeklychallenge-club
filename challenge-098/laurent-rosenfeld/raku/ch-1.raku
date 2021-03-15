use v6;

my $input = @*ARGS[0] // "I_have_a_dream.txt";

given $input.IO.open {
    for 0..2 -> $num {
        my $n = (1..10).pick;
        say "Taking $n characters: ", .readchars: $n;
    }
}
