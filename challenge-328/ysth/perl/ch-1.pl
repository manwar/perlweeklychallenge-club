use 5.036;

my @inputs = @ARGV;

my $replace_all_qs = qr'
    (?<a> (?<!a) \? (?! a | \? (?:\?{2})* (?![a?]) | (?:\?{2})* a ))
    | (?<b> (?<! b | \? (?<! (?<!a) \? (?! \? (?:\?{2})* (?![a?]) | (?:\?{2})+ a ) ) ) \? (?!b))
    | (?<c>\?)
'x;

for my $string (@inputs) {
    my $new_string = $string =~ s/$replace_all_qs/@{[keys %+]}/gr;
    printf "| %s | %s |\n", $string, $new_string;
}
