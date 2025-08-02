use strict;
use warnings;
use feature 'say';

sub sort_string {
    my @positions;
    my @words = split /\s+/, shift;
    for my $word (@words) {
        my ($letters, $digits) = ($word =~ m/(\D+)(\d+)/);
        $positions[$digits] = $letters;

    }
    return "@positions[1..$#positions]";
}
my @tests = ("and2 Raku3 cousins5 Perl1 are4",
            "guest6 Python1 most4 the3 popular5 is2 language7",
            "Challenge3 The1 Weekly2");
for my $test (@tests) {
    say $test;
    say sort_string $test;
    say "";
}
