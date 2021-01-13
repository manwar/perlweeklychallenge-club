#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub combinations {
    my @list = @{$_[0]};
    my $length = $_[1];

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

sub pick {
    my @list = @{$_[0]};
    my $length = scalar @list;
    my $n = $_[1] // 1;
    my @picked;

    while (scalar @picked != $n) {
        my $pos = int(rand($length));
        if (defined $list[$pos]) {
            push @picked, $list[$pos];
            $list[$pos] = undef;
        }
    }

    return wantarray ? @picked : $picked[0];
}

sub makeWords {
    my $list = '/usr/share/dict/words';

    open my $wordList, '<', $list or die "$list: $!\n";
    local $RS;
    my $contents = <$wordList>;
    close $wordList;

    my %words =
           map { uc $_ => $_ }
           grep { length() < 8 && /^[[:alpha:]]+$/ }
           split /\n/,
           $contents;

    my %dict;
    for my $word (keys %words) {
        push @{$dict{ join q{}, (sort split //, $word)}}, $word;
    }
    return %dict;
}

sub pickTiles {
    return pick([split //,
        'A' x 8 . 'G' x 3 . 'I' x 5 . 'S' x 7 . 'U' x 5 . 'X' x 2 . 'Z' x 5 .
        'E' x 9 . 'J' x 3 . 'L' x 3 . 'R' x 3 . 'V' x 3 . 'Y' x 5 . 'F' x 3 .
        'D' x 3 . 'P' x 5 . 'W' x 5 . 'B' x 5 . 'N' x 4 . 'T' x 5 . 'O' x 3 .
        'H' x 3 . 'M' x 4 . 'C' x 4 . 'K' x 2 . 'Q' x 2], 7);
}

sub calculateScore {
    my ($string) = @_;

    my %scores = (
        'A' => 1, 'G' => 1, 'I' => 1, 'S' => 1,  'U' => 1, 'X' => 1, 'Z' => 1,
        'E' => 2, 'J' => 2, 'L' => 2, 'R' => 2,  'V' => 2, 'Y' => 2, 'F' => 3,
        'D' => 3, 'P' => 3, 'W' => 3, 'B' => 4,  'N' => 4, 'T' => 5, 'O' => 5,
        'H' => 5, 'M' => 5, 'C' => 5, 'K' => 10, 'Q' => 10  );

    my $total = 0;
    for my $c (split //, $string) {
        $total += $scores{$c};
    }

    return $total;
}

my %dict = makeWords();
my @draw = pickTiles();

my $bestScore = 0;
my $bestWord = q{};
my $length = 7;

while ($length) {
    for my $tiles
    (map { join q{}, @{$_}; } combinations([sort @draw], $length)) {

        if (exists $dict{$tiles}) {
            my $value = @{$dict{$tiles}}[0];
            my $score = calculateScore($value);

            if ($score > $bestScore ||
            ($score == $bestScore && length $value > length $bestWord)) {
                $bestScore = $score;
                $bestWord = $value;
            }
        }

    }
    $length--;
}

say +(join q{}, @draw), " = $bestWord ($bestScore)";