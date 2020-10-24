#!/usr/bin/perl
use warnings;
use strict;

# Substitution returns the number of substitutions.
sub words_length_subst {
    local ($_) = @_;
    s/^\S+//, s/\S+$//;
    return s/\S/ /g
}

# Or remove the words and all whitespace and measure the length.
sub words_length {
    local ($_) = @_;
    s/^\S+//, s/\S+$//, s/ //g;
    return length
}

# Transliteration returns the number of replaced chars and is fast.
sub words_length_trans {
    local ($_) = @_;
    s/^\S+//, s/\S+$//;
    return tr/\t\n\r\f\ck //c
}

use Test::More tests => 6;
my %examples = ('The Weekly Challenge'                    => 6,
                'The purpose of our lives is to be happy' => 23);

for my $sub (\&words_length_subst, \&words_length, \&words_length_trans) {
    for my $example (keys %examples) {
        is $sub->($example), $examples{$example};
    }
}

use Benchmark qw{ cmpthese };
my $s = join ' ', map { 'x' x rand 10 } 1 .. 100;
cmpthese(-3, {
    subst => sub { words_length_subst($s) },
    len   => sub { words_length($s) },
    trans => sub { words_length_trans($s) },
});

__END__
          Rate subst   len trans
subst  12326/s    --  -79%  -90%
len    59388/s  382%    --  -50%
trans 119673/s  871%  102%    --
