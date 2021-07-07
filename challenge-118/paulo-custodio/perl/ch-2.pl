#!/usr/bin/env perl

# Challenge 118
#
# TASK #2 - Adventure of Knight
# Submitted by: Cheok-Yin Fung
# A knight is restricted to move on an 8×8 chessboard. The knight is denoted by
# N and its way of movement is the same as what it is defined in Chess.
# * represents an empty square. x represents a square with treasure.
#
# The Knight’s movement is unique. It may move two squares vertically and one
# square horizontally, or two squares horizontally and one square vertically
# (with both forming the shape of an L).
#
# There are 6 squares with treasures.
#
# Write a script to find the path such that Knight can capture all treasures.
# The Knight can start from the top-left square.
#
#       a b c d e f g h
#     8 N * * * * * * * 8
#     7 * * * * * * * * 7
#     6 * * * * x * * * 6
#     5 * * * * * * * * 5
#     4 * * x * * * * * 4
#     3 * x * * * * * * 3
#     2 x x * * * * * * 2
#     1 * x * * * * * * 1
#       a b c d e f g h
#

# https://en.m.wikipedia.org/wiki/Knight%27s_tour

use Modern::Perl;
use Clone 'clone';

{
    package Board;
    use Object::Tiny::RW qw( board treasures path );

    sub new {
        my($class) = @_;
        my $self = bless {
            board => [[],[],[],[],[],[],[],[]],
            treasures => {},
            path => [],
        }, $class;
        return $self;
    }

    sub parse {
        my($self) = @_;
        $self->board([[],[],[],[],[],[],[],[]]);
        $self->treasures({});
        $self->path([]);

        local $_;
        $_ = <>;
        /a b c d e f g h/i or die "expected header";
        for my $row (0..7) {
            my $y = 8 - $row;
            $_ = <>;
            s/^ \s* $y \s*//x or die "expected row $y";
            for my $col (0..7) {
                my $x = chr(ord('a') + $col);
                s/^ (\S) \s* //x or die "expected cell $x$y";
                my $cell = $1;
                if ($cell eq 'N') {
                    push @{$self->path}, [$row, $col];
                    $self->board->[$row][$col] = 1;
                }
                elsif ($cell eq 'x') {
                    $self->treasures->{"$row$col"} = 1;
                }
            }
        }
        $_ = <>;
        /a b c d e f g h/i or die "expected footer";
    }

    sub next_moves {
        my($self, $row, $col) = @_;
        my @next;
        for ([-2, -1], [-2, +1], [+2, -1], [+2, +1],
             [+1, -2], [-1, -2], [+1, +2], [-1, +2]) {
            my($drow, $dcol) = @$_;
            my $nrow = $row + $drow;
            my $ncol = $col + $dcol;
            if ($nrow >= 0 && $nrow < 8) {
                if ($ncol >= 0 && $ncol < 8) {
                    if (!$self->board->[$nrow][$ncol]) {
                        push @next, [$nrow, $ncol];
                    }
                }
            }
        }
        return @next;
    }

    sub next_possible_moves {
        my($self) = @_;

        # get current position
        my($row, $col) = @{$self->path->[-1]};

        # get possible moves from here
        my @next = $self->next_moves($row, $col);

        # count possible moves from each destination
        my $min_count = 1e10;
        for (@next) {
            my($nrow, $ncol) = @$_;
            my $count = $self->next_moves($nrow, $ncol);
            push @$_, $count;
            $min_count = $count if $min_count > $count;
        }

        # select move(s) with less count
        @next = grep {$_->[2] == $min_count} @next;

        return @next;
    }

    sub path_str {
        my($self) = @_;
        my @moves;
        for (@{$self->path}) {
            my($row, $col) = @$_;
            my $x = chr(ord('a') + $col);
            my $y = 8 - $row;
            push @moves, "$x$y";
        }
        return "@moves";
    }

    sub str {
        my($self) = @_;
        my $ret = "  a b c d e f g h\n";
        for my $row (0..7) {
            my $y = 8 - $row;
            $ret .= "$y ";
            for my $col (0..7) {
                if (exists $self->treasures->{"$row$col"}) {
                    $ret .= "x ";
                }
                elsif ($self->board->[$row][$col]) {
                    $ret .= "N ";
                }
                else {
                    $ret .= "* ";
                }
            }
            $ret .= "$y\n";
        }
        $ret .= "  a b c d e f g h\n";
        $ret .= $self->path_str . "\n";

        return $ret;
    }

}

sub solve {
    my($psolution, $board) = @_;
    my $solution = $$psolution;

    if (%{$board->treasures} == 0) { # all treasures found
        if (@{$solution->path} == 0 ||
            @{$solution->path} > @{$board->path}) {
            $$psolution = clone($board);
        }
    }
    else {
        my @next = $board->next_possible_moves;
        for (@next) {
            my($row, $col) = @$_;
            my $new_board = clone($board);
            $new_board->board->[$row][$col] = 1;
            push @{$new_board->path}, [$row, $col];
            delete $new_board->treasures->{"$row$col"};
            solve($psolution, $new_board);
        }
    }
}

my $board = Board->new;
my $solution = Board->new;
$board->parse;
solve(\$solution, $board);
say $solution->path_str;
