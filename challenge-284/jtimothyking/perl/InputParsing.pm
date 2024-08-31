package InputParsing;
use v5.38;

sub get_ints {
    my ($line, $symbol) = @_;
    $symbol //= 'ints';
    chomp($line);
    $line =~ m[
        \A \s*
        \@$symbol \s* = \s* \(
            ( \d+ (?: \s* , \s* \d+ )* )
        \)
        \s* \z
    ]x;
    my @ints = split /\s*,\s*/, $1 // '';
    @ints or die "Invalid line for $symbol: $line\n";
    return @ints;
}


1;