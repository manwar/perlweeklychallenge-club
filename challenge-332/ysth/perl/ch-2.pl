use 5.036;

sub odd_letters($string) {
    join('', sort split //, $string) !~ /(\pL)(?<!(?=\1\1)..)(?:\1\1)*+(?=\1)/
}

sub main() {
    my @inputs = @ARGV;
    for my $string (@inputs) {
        printf "%-30s -> %s\n", $string, (odd_letters($string) ? 'true' : 'false');
    }
}

main() unless caller;
