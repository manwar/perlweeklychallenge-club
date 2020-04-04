use v6;

my %successors = (
    'a' => ['e', 'i'],
    'e' => ['i'],
    'i' => [qw /a e o u/],
    'o' => ['a', 'u'],
    'u' => ['e', 'o']
);
my @vowels = sort %successors.keys;
sub MAIN (UInt $str_size where 1 <= * <= 5) {
    my $error_msg = "Please pass a parameter between 1 and 5.";
    die $error_msg unless $str_size ~~ /^<[1..5]>$/;
    for @vowels -> $start {
        make_str($str_size -1, $start, $start);
    }
}
sub make_str (UInt $left, Str $last, Str $string) {
    say $string and return unless $left;
    for |%successors{$last} -> $next {
        my $new_str = $string ~ $next;
        make_str($left -1, $next, $new_str);
    }
}
