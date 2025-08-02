use v5.38;

sub proc($date) {
    say "Input : $date";
    my @newnum = map {sprintf("%b", $_)} split "-", $date;
    my $o = join "-", @newnum;
    say "Output: $o";
}

my $date = "2025-07-26";
proc($date);

$date = "2000-02-02";
proc($date);

$date = "2024-12-31";
proc($date);
