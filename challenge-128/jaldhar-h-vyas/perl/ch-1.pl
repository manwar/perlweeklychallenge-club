#!/usr/bin/perl
use 5.40.1;
use feature qw/ class /;
use warnings;
no warnings qw/ experimental::class /;

class Submatrix {
    field $top :param :reader;
    field $left :param :reader;  
    field $bottom :param :reader;
    field $right :param :reader;
    field $height:reader;    
    field $width :reader;    
    field $area :reader;    

    ADJUST {
        $height = $bottom - $top + 1;
        $width = $right - $left + 1;
        $area = $height * $width;
    }
}

my @matrix = map { [ split /\s+/, $_ ] } @ARGV;
my $m = scalar @matrix - 1;
my $n = scalar @{$matrix[0]} - 1;

my $best = Submatrix->new(top => 0, left => 0, bottom => 0, right => 0);
my $bestArea = 0;

for  my $top (0 .. $m) {
    for my $left (0 .. $n) {
        for my $bottom ($top .. $m) {
            for my $right ($left .. $n) {
                my $current = Submatrix->new(top => $top, left => $left,
                    bottom => $bottom, right => $right);

                my $isZero = true;

                LOOP: for my $row ($top .. $bottom) {
                    for my $column ($left .. $right) {
                        if ($matrix[$row]->[$column] != 0) {
                            $isZero = false;
                            last LOOP;
                        }
                    }
                }

                if ($isZero && ($current->area > $best->area ||
                $current->area == $best->area && $current->width > $best->width)) {
                    $best = $current;
                }
            }
        }
    }
}

for my $row ($best->top .. $best->bottom) {
    say q{[ }, (join q{ }, @{$matrix[$row]}[$best->left .. $best->right]), q{ ]};
}
