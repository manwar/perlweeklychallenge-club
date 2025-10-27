#!/usr/bin/perl
use 5.038;
use builtin qw/ true false /;
use warnings;
no warnings qw/ experimental::builtin /;

sub permute(@arr) {
    my @permutations;

    if (scalar @arr eq 1) {
        return (\@arr);
    }

    my @idx = keys @arr;
    while ( push @permutations, [@arr[@idx]] ) {
        my $p = scalar @idx - 1;
        while ($idx[$p-1] >= $idx[$p]) {
            --$p;
        }
        my $q = $p;
        if (!$q) {
            last;
        }
        push @idx, reverse splice @idx, $p;
        while ($idx[$p-1] > $idx[$q]) {
            ++$q;
        }
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }

    return @permutations;
}

my @target = split /\s+/, shift;
my @source = map { [split /\s+/] } @ARGV;

my $trg = join q{}, @target;
my $result = false;

for my $p ( permute(@source) ) {
    my $src = join q{}, map { join q{}, @$_ } @$p;
    if ($src eq $trg) {
        $result = true;
        last;
    }
}

say $result ? "True" : "False";