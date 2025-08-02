use 5.036;

my @inputs = @ARGV;

my $bad_pair = qr/(?i:(.)\1)(?<!(?=\1).)/;

for my $string_in (@inputs) {
    my $string_out = $string_in;
    1 while $string_out =~ s/$bad_pair//g;
    printf "%-30s -> %-30s\n", $string_in, $string_out;
}
