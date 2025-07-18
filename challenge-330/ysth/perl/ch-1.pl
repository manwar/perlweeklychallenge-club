use 5.036;

sub clear_digits($string) {
    $string =~ s/[0-9]*(?<pair>[a-z](?&pair)?[0-9])*//gr;
}

sub main() {
    my @inputs = @ARGV;
    for my $string (@inputs) {
        printf "%-30s -> %s\n", $string, clear_digits($string);
    }
}

main() unless caller;
