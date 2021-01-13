#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S>
  
    <S>    digit string (0 - 9, *, #)
-USAGE-
    exit(0);
}

sub X {
    my @a = @{ $_[0] };
    my @b = @{ $_[1] };

    return map {
        my $first = $_;
        map { 
            [ ref $first eq 'ARRAY' ? @{$first} : $first, $_ ];
        } @b;
    } @a;
}

if (scalar @ARGV < 1 || $ARGV[0] !~ /^ [0-9\*\#]+ $/msx) {
    usage();
}

my $S = $ARGV[0];

my %digits = (
    1   => [ q{_}, q{,}, q{@} ],
    2   => [qw/ a b c /],
    3   => [qw/ d e f /],
    4   => [qw/ g h i /],
    5   => [qw/ j k l /],
    6   => [qw/ m n o /],
    7   => [qw/ p q r s /],
    8   => [qw/ t u v /],
    9   => [qw/ w x y z /],
    0   => [ q{} ],
    '*' => [ q{ } ],
    '#' => [ q{} ],
);

my @letters = map { $digits{$_} } split //, $S;
my @result = @{ $letters[0] };

for my $i (1 .. (scalar @letters) - 1 ) {
    @result = X(\@result, $letters[$i]);
}

say q{[}, (join q{, }, map { q{"} . (join q{}, @{$_}) . q{"} } @result), q{]};