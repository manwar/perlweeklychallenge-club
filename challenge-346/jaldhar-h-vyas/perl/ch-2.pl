#!/usr/bin/perl
use 5.038;
use warnings;
use feature qw/ class /;
no warnings qw/ experimental::class /;

class DepthFirstSearch {
    field $str :param;
    field $target :param;
    field $n = length($str);
    field @result = ();

    method find() {
        $self->search(0, '', 0, 0);
        return @result;
    }

    method search($i, $expr, $current, $previous) {
        if ($i == $n) {
            if ($current == $target) {
                push @result, $expr;
            }
            return $self;
        }

        for my $len (1 .. ($n - $i)) {
            my $part = substr($str, $i, $len);
            next if length($part) > 1 && $part =~ /^0/;
            my $num = int($part);

            if ($i == 0) {
                $self->search($i + $len, $part, $num, $num);
            } else {
                $self->search(
                    $i + $len, $expr . '*' . $part,
                    $current - $previous + $previous * $num, $previous * $num);
                $self->search($i + $len, $expr . '+' . $part,
                    $current + $num, $num);
                $self->search($i + $len, $expr . '-' . $part,
                    $current - $num, -$num);
            }
        }
        return $self;
    }
}

my ($str, $target) = @ARGV;
my $dfs = DepthFirstSearch->new(str => $str, target => $target);
say q{(}, (join q{, }, map { "\"$_\"" } $dfs->find), q{)};