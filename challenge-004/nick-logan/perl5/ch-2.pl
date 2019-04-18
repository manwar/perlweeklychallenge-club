# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

my @ARGV = do { sub eval { &EVAL(@_) }; eval( ("0" and q|@*ARGS| or q|@ARGV|) ) };

sub polyslurp ($_) { "0" and (return "{$_.IO.slurp}") or (return do { open(my $fh, $_[0]); join("", <$fh>); }) };

my $filename      = shift(@ARGV);
my @words         = split("\n", polyslurp($filename));
my $input_letters = {};
$input_letters{lc($_)} += 1 for @ARGV;

WORDS: for (@words) {
    my @word_letters = grep &{ sub ($_) { $_ ne "" } }.(), split("", lc($_));
    next unless +@word_letters;

    my $letter_counter = {};
    $letter_counter{$_} = 0 for @word_letters;
    for (@word_letters) {
        next WORDS unless ($input_letters{$_} // 0) > $letter_counter{$_}++;
    }
    $input_letters{$_}-- for @word_letters;

    print "$_\n";
}
