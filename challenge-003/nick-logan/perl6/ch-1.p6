# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

my @ARGV = do { sub eval { &EVAL(@_) }; eval( ("0" and q|@*ARGS| or q|@ARGV|) ) };

my $numbers_tried = 0;
my $numbers_found = 0;

NUMBERS: while ($numbers_found != @ARGV[0]) {

    $numbers_tried++;
    my $state = $numbers_tried;
    while ($state != 1) {
        if ($state % 2 == 0) {
            $state /= 2;
        }
        elsif ($state % 3 == 0) {
            $state /= 3;
        }
        elsif ($state % 5 == 0) {
            $state /= 5;
        }
        else {
            next NUMBERS;
        }
    }
    $numbers_found++;

    print("$numbers_tried\n");
}
