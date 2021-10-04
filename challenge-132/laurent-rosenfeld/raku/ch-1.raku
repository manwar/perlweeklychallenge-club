use v6;

my $today =  Date.new("2021-09-22");
for "2021-09-18", "1975-10-10", "1967-02-14" -> $test {
    my $input = Date.new($test);
    my $time-diff = $today - $input;
    say "Mirror dates for $input are: ",
        $input - $time-diff, " and ", $today + $time-diff;
}
