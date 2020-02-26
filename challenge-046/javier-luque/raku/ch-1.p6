# Test: perl6 ch-1.p6
use v6.d;

# The message
our $message =
'P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0';

sub MAIN() {

    # Initialize the columns hash
    my @column_hash;
    my ($first_line) = $message.split("\n", 2);
    my $length = $first_line.split(" ").join.chars;
    @column_hash[0 .. $length - 1] = {};

    # Parse the cryptic message
    for ($message.split("\n")) -> $line {
        my $i = 0;
        for ($line.split(" ")) -> $char {
            @column_hash[$i++].{$char}++;
        }
    }

    # Sort
    my $output = '';
    for (@column_hash) -> %column {
        $output = $output ~
            %column.keys.sort(
                { %column.{$^b} <=> %column.{$^a} }
            )[0];
    }

    say $output;
}
