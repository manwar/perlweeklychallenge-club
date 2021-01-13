use v5.12;

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/

# Comments: https://andrewshitov.com/2020/09/08/lonely-x-the-weekly-challenge-77-task-2/

my @matrix = (
    [qw( O O O X)],
    [qw( X O O O)],
    [qw( O X O X)],
);

for (@matrix) {
    unshift @$_, 'O';
    push @$_, 'O';
}
unshift @matrix, [map {'O'} 1..scalar(@{$matrix[0]})];
push @matrix, [map {'O'} 1..scalar(@{$matrix[0]})];

# use Data::Dumper;
# say Dumper(\@matrix);

my $matrix = join '', map({join '', @$_} @matrix);
# say $matrix;

my $width = scalar(@{$matrix[0]});
my $gap = '.' x ($width - 3);
my $pattern = "OOO${gap}OXO${gap}OOO";

for my $pos (0 .. length($matrix) - length($pattern)) {
    # say substr($matrix, $pos) . " ~ " . $pattern;
    next unless substr($matrix, $pos) =~ /^$pattern/;
    my $y = int($pos / $width);
    my $x = $pos - $y * $width;

    say "$y, $x";
}
