#!/usr/bin/perl
use 5.020;
use warnings;

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

if (scalar @ARGV != 2) {
    die "Need two integers.\n";
}

my ($u, $v) = @ARGV;

my @ulams = ($u, $v, $u + $v);

while (scalar @ulams < 10) {
    my @candidates = map { $_->[0] + $_->[1] } combinations(\@ulams, 2);


    my %freq;
    for my $candidate (@candidates) {
        $freq{$candidate}++;
    }
    @candidates = grep { %freq{$_} < 2 } keys %freq;

    @candidates = grep { $a = $_; !grep { $_ == $a } @ulams; } @candidates;

    push @ulams, (sort { $a <=> $b} @candidates)[0];
}

say join q{, }, @ulams;
