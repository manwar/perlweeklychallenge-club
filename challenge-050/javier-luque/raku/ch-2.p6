# Test: perl6 ch-2.p6
use v6.d;

sub MAIN() {
    my $list_size = 50;

    # Create @L
    my @L = ((1 .. 50).roll: $list_size) ;

    # Output the list
    say 'List: ' ~ @L.perl;

    # Find Noble number
    my $noble =
        @L.sort.pairs.grep(
            {.key == $list_size - .value}
        )>>.value;

    # Output it if found
    say "Noble found: " ~ $noble
        if ($noble);
}
