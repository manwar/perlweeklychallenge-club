#!/usr/bin/perl
use v5.38;

sub permute :prototype(&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}

my @matrix = map { [ split /\s+/, $_ ] } @ARGV;
my $minimumLength = "Inf";
my @tour = ();

my @permutations;
permute { push @permutations, \@_; } keys @{$matrix[0]};

for my $perm (@permutations) {
    my $cost = 0;
    my $from = 0;

    my @cities = grep { $_ != 0} @{$perm};
    for my $i (keys @cities) {
        $cost += $matrix[$from]->[$cities[$i]];
        $from = $cities[$i];
    }
    $cost += $matrix[$from]->[0];

    if ($cost < $minimumLength) {
        $minimumLength = $cost;
        @tour = @cities;
    }
}

say "length = $minimumLength";
say 'tour = (0 ', (join q{ }, @tour), ' 0)'; 