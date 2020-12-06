use strict;
use warnings;
use feature "say";
use constant SUM => 15;

my @in = 1..9;
my @permutations;

sub print_matrix {
    my @matrix = ( [@{$_}[0..2]], [@{$_}[3..5]], [@{$_}[6..8]] );
    for my $row (@matrix)  {
        say "[", (map { sprintf "% 2i", $_ } @$row), " ]"; # for @$row;
    }
    say " ";
}

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub permute {
    my ($in, $left) = @_;
    if (scalar @$left == 0) {
        return
            # lines
            if sum( @{$in}[0..2]) != SUM
            or sum( @{$in}[3..5]) != SUM
            or sum( @{$in}[6..8]) != SUM
            # columns
            or sum( @{$in}[0, 3, 6]) != SUM
            or sum( @{$in}[1, 4, 7]) != SUM
            or sum( @{$in}[2, 5, 8]) != SUM
            # diagonals
            or sum( @{$in}[0, 4, 8]) != SUM
            or sum( @{$in}[2, 4, 6]) != SUM;
        push @permutations, $in;
        return;
    }
    for my $candidate (@$left) {
        my @vals = @$in;
        push @vals, $candidate;
        permute(\@vals, [grep $_ != $candidate, @$left]);
    }
}

permute [], \@in;
print_matrix \$_ for @permutations;
