#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %dict;

sub put {
    my ($dict, @chars) = @_;
    if (@chars) {
        my $ch = shift @chars;
        $dict->{$ch} = {} unless exists $dict->{$ch};
        put($dict->{$ch}, @chars);
    } else {
        undef $dict->{""};
    }
}

sub get {
    my ($dict, $chars, $path) = @_;
    $path //= "";
    my $ch = $chars->[0] // "";
    my @r;
    @r = ($path . $ch)
        if exists $dict->{$ch} && exists $dict->{$ch}{""};
    push @r, get($dict->{$ch}, [ @$chars[1 .. $#$chars] ], $path . $ch)
        if @$chars;
    return @r
}

my %found;
sub examine {
    my ($s) = @_;
    my $length = length $s;
    for my $string (map lc, $s, scalar reverse $s) {
        for my $pos (0 .. $length - 1) {
            if (
                my @matches = get(\%dict, [split //, substr $string, $pos])
            ) {
                @found{@matches} = ();
            }
        }
    }
}

my ($grid, $words) = @ARGV;

open my $w, '<', $words or die $!;
while (<$w>) {
    chomp;
    put(\%dict, split //, lc);
}

open my $g, '<', $grid or die $!;
chomp( my @grid = <$g> );
s/ //g for @grid;

my $length = length $grid[0];

for my $pos (1 .. $length) {
    my $column;
    for my $line (@grid) {
        examine($line) if 1 == $pos;
        $column .= substr $line, $pos - 1, 1;
    }
    examine($column);
}

my ($X, $Y) = (0, 0);
for (1 .. @grid + $length - 1) {
    my ($x, $y) = ($X, $Y);
    my %diag;
    while ($y >= 0 && $x <= $length - 1) {
        $diag{NW} .= substr $grid[$y], $x, 1;
        $diag{NE} .= substr $grid[$y], -$x - 1, 1;
        ++$x, --$y;
    }
    examine($diag{$_}) for qw( NW NE );
    if ($Y < $#grid) {
        ++$Y;
    } else {
        ++$X;
    }
}

say for sort keys %found;

__END__

time ch-2.pl pwc076-2.grid <(grep -E '^.{5,}' /usr/share/dict/british) | wc -l

58

real	0m3.629s
user	0m3.567s
sys	0m0.065s

American English dictionary gives two more: socializing and succor.
