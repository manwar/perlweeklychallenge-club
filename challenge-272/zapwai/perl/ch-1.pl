use v5.38;
my $ip = "1.1.1.1";
proc($ip);
$ip = "255.101.1.0";
proc($ip);

sub proc($ip) {
    my @nums = split '\.', $ip;
    my $out = join "[.]", @nums;
    say "Input: $ip";
    say "Output: $out";
}
