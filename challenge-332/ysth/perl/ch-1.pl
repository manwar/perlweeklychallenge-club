use 5.036;

sub binary_date($date) {
    $date =~ s/([0-9]+)/sprintf '%b', $1/gre
}

sub main() {
    my @inputs = @ARGV;
    for my $date (@inputs) {
        printf "%-30s -> %s\n", $date, binary_date $date;
    }
}

main() unless caller;
