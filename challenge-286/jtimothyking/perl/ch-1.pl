#!/usr/bin/perl
use v5.38;
use warnings;

my $quine_string = q(
    #!/usr/bin/perl
    use v5.38;
    use warnings;

    $quine_string = q( %s );
    my @words = split ' ', sprintf $quine_string, $quine_string;
    my $random_word = $words[rand @words];
    print "$random_word\n";

    __END__
);
my @words = split ' ', sprintf $quine_string, $quine_string;
my $random_word = $words[rand @words];
print "$random_word\n";

__END__
