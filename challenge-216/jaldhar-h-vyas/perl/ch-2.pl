#!/usr/bin/perl
use 5.030;
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

sub combUnique {
    my ($str) = @_;

    my @chars = split //, $str;
 
    my %unique;
    for my $c (@chars) {
        $unique{$c}++;
    }

    return keys %unique;
}

sub isSubset {
    my @subset = @{$_[0]};

    my %set;
    for my $c (@{$_[1]}) {
        $set{$c}++;
    }

    for my $c (@subset) {
        if (!exists $set{$c} || $set{$c} == 0) {
            return undef;
        }
        $set{$c}--;
    }

    return 1;
}

sub xx {
    my ($array, $amount) = @_;
    my @result = @{$array};

    for (1 .. $amount - 1) {
        push @result, @{$array};
    }

    return @result;
}

my ($word, @stickers) = @ARGV;

unless (isSubset([combUnique($word)], [combUnique(join q{}, @stickers)])) {
    say 0;
    exit;
}

my @stickerList =  xx(\@stickers, scalar combUnique($word));
my @chars = split //, $word;
my $result = 0;

LOOP: for my $i (1 .. scalar @stickerList) {
    for my $combo (combinations(\@stickerList, $i)) {
        my @sticker = split //, (join q{}, @{$combo});
        if (isSubset(\@chars, \@sticker)) {
            $result = scalar @{$combo};
            last LOOP;
        }
    }
}

say $result;
