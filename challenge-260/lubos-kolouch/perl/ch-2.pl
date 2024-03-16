package ch2;
use strict;
use warnings;
use List::Util qw(reduce);

sub factorial {
    my ($n) = @_;
    return reduce { $a * $b } 1, 1 .. $n;
}

sub dictionary_rank {
    my ($word) = @_;
    my $length = length($word);
    my %char_counts;
    $char_counts{$_}++ for split //, $word;
    my $rank = 1;

    for my $i ( 0 .. $length - 1 ) {
        my $char          = substr( $word, $i, 1 );
        my $smaller_chars = 0;
        $smaller_chars += $char_counts{$_}
          for grep { $_ lt $char } keys %char_counts;

        $rank +=
          $smaller_chars * factorial( $length - $i - 1 ) / reduce { $a * $b } 1,
          map { factorial($_) } values %char_counts;

        $char_counts{$char}--;
        delete $char_counts{$char} if $char_counts{$char} == 0;
    }

    return $rank;
}

print dictionary_rank('CAT'),    "\\n";
print dictionary_rank('GOOGLE'), "\\n";
print dictionary_rank('SECRET'), "\\n";

1;
