#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub allUnique {
    my ($word) = @_;
    my %count;
    for my $letter (split //, $word) {
        $count{$letter}++;
    }


    return (scalar grep { $count{$_} > 1} keys %count) == 0;
}

sub intersect {
    my ($first, $second) = @_;
    my %count;

    foreach (@{$first}, @{$second}) {
        $count{$_}++;
    }

    my @intersection = sort grep { $count{$_} > 1 } keys %count;

    return wantarray ? @intersection : \@intersection;
}

sub remove {
    my ($first, $second) = @_;

    for my $letter (@{$second}) {
        @{$first} = grep {$_ ne $letter; } @{$first};
    }

    return wantarray ? @{$first} : $first;
}

sub makePangram {
    my ($wordlists, $order) = @_;
    my @pangram = ();
    my @used;

    while(1) {
        my $letter = $order->[0];
        my @choices = sort { (length $a) <=> (length $b) } @{$wordlists->{$letter}};
        my $word = q{};

        my $best = 26;
        my @matches;
        for my $choice (@choices) {
            @matches = @{intersect([ split //, $choice ], \@used)};
            if (scalar @matches <= $best) {
                $best = scalar @matches;
                $word = $choice;
            }
        }

        push @pangram, $word;
        push @used, remove([split //, $word], \@used);
        $order = remove($order, \@used);

        if (! scalar @{$order}) {
            last;
        }
    }

    return wantarray ? @pangram : \@pangram;
}

sub count {
    my ($pangram) = @_;
    my $total = 0;

    for my $word (@{$pangram}) {
        $total += length $word;
    }

    return $total;
}

my %wordlists;

open my $dictionary, '<', 'dictionary.txt' or die "$OS_ERROR\n";
while (my $line = <$dictionary>) {
    chomp $line;
    my $word = $line;
    my @letters = split //, $word;
    if ($word eq (join q{}, sort @letters) && allUnique($word)) {
        for my $letter (@letters) {
            push @{$wordlists{$letter}}, $word;
        }
    }
}
close $dictionary;

my @order = sort { scalar @{$wordlists{$a}} <=> scalar @{$wordlists{$b}} } ('a' .. 'z');

my $pangram = makePangram(\%wordlists, \@order);

say "'", (join q{ }, @{$pangram}), "' has ", count($pangram), ' letters.';
