my @abecedarian;
my $dict = "./dictionary.txt";
open my $IN, "<", $dict or die "Cannot open $dict $!";
WORD: while (my $word = <$IN>) {
    chomp $word;
    my $old = 'a';
    for my $char (split //, $word) {
        next WORD if $char lt $old;
        $old = $char;
    }
    push @abecedarian, $word;
}
my @out = sort { length $b <=> length $a } @abecedarian;
say $_ for @out[0..25];
