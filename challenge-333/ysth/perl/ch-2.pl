use 5.036;

sub duplicate_zeros(@inputs) {
    (map $_ || ($_,$_), @inputs)[0..$#inputs]
}

sub main() {
    my @inputs = @ARGV;

    say join ' ', duplicate_zeros(@inputs);

    return;
}

main() unless caller;
