#! /usr/bin/perl
use warnings;
use strict;

sub minesweeper_game {
    my ($input) = @_;
    $input =~ s/\*/0/g;
    my @grid = map [split], split "\n", $input;
    for my $x (0 .. $#grid) {
        for my $y (0 .. $#{ $grid[$x] }) {
            next unless 'x' eq $grid[$x][$y];

            for my $dx (-1, 0, 1) {
                for my $dy (-1, 0, 1) {
                    next if 0 == $dx && 0 == $dy;

                    my $X = $x + $dx;
                    my $Y = $y + $dy;
                    next if $X < 0 || $Y < 0
                         || $X > $#grid || $Y > $#{ $grid[$X] }
                         || 'x' eq $grid[$X][$Y];

                    ++$grid[$X][$Y];
                }
            }
        }
    }
    return join "", map "@$_\n", @grid
}

use Test2::V0;
plan 1;

my $test_input = << '__TEST__';
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
__TEST__

my $expected = << '__EXPECTED__';
x 1 0 1 x 2 x x x x
1 1 0 2 2 4 3 5 5 x
0 0 1 3 x 3 x 2 x 2
1 1 1 x x 4 1 2 2 2
x 1 1 3 x 2 0 0 1 x
__EXPECTED__

is minesweeper_game($test_input), $expected, 'Example';

=head1 The Minesweeper game at Rosettacode

In fact, I'm the author of the Minesweeper Perl code at Rosettacode.
Here's a slightly improved version if you want to play it:

=cut

__END__

#! /usr/bin/perl
use warnings;
use strict;

{   package Local::Field;

    use constant {
        REAL  => 0,
        SHOW  => 1,
        COUNT => 2,
    };


    sub new {
        my ($class, $width, $height, $percent) = @_;
        my $field;
        for my $x (1 .. $width) {
            for my $y (1 .. $height) {
                $field->[$x - 1][$y - 1][REAL] = ' ';
                $field->[$x - 1][$y - 1][SHOW] = '.';
            }
        }
        for (1 .. $percent / 100 * $width * $height) {
            my ($x, $y) = map int rand $_, $width, $height;
            redo if 'm' eq $field->[$x][$y][REAL];

            $field->[$x][$y][REAL] = 'm';
            for my $i ($x - 1 .. $x + 1) {
                for my $j ($y - 1 .. $y + 1) {
                    $field->[$i][$j][COUNT]++
                        if $i >= 0 && $j >= 0
                        && $i <= $#$field && $j <= $#{ $field->[0] };
                }
            }
        }
        bless $field, $class
    }


    sub show {
        my ($self) = @_;
        print "\n  ";
        printf '%2d ', $_ + 1 for 0 .. $#$self;
        print "\n";

        for my $row (0 .. $#{ $self->[0] }) {
            printf '%2d ', 1 + $row;
            for my $column (0 .. $#$self) {
                print $self->[$column][$row][SHOW], '  ';
            }
            print "\n";
        }
    }


    sub _validate {
        my ($self, $x, $y) = @_;
        return 1
            if $x <= $#$self
            && $y <= $#{ $self->[0] }
            && $x >= 0
            && $y >= 0;

        print "Invalid coordinates!\n";
        return 0
    }


    sub mark {
        my ($self, $x, $y) = @_;
        $_-- for $x, $y;
        return unless $self->_validate($x, $y);

        if ('.' eq $self->[$x][$y][SHOW]) {
            $self->[$x][$y][SHOW] = '?';

        } elsif ('?' eq $self->[$x][$y][SHOW]) {
            $self->[$x][$y][SHOW] = '.';
        }
    }


    sub end {
        my ($self) = @_;
        for my $y (0 .. $#{ $self->[0] }) {
            for my $x (0 .. $#$self) {
                $self->[$x][$y][SHOW] = '!' if '.' eq $self->[$x][$y][SHOW]
                    && 'm' eq $self->[$x][$y][REAL];
                $self->[$x][$y][SHOW] = 'x' if '?' eq $self->[$x][$y][SHOW]
                    && 'm' ne $self->[$x][$y][REAL];
            }
        }
        $self->show;
        exit
    }


    sub _declassify {
        my ($self, $x, $y) = @_;
        return if '.' ne $self->[$x][$y][SHOW];

        if (' ' eq $self->[$x][$y][REAL] && '.' eq $self->[$x][$y][SHOW]) {
            $self->[$x][$y][SHOW] = $self->[$x][$y][COUNT] || ' ';
        }
        return if ' ' ne $self->[$x][$y][SHOW];

        for my $i ($x - 1 .. $x + 1) {
            next if $i < 0 || $i > $#$self;

            for my $j ($y - 1 .. $y + 1) {
                next if $j < 0 || $j > $#{ $self->[0] };

                no warnings 'recursion';
                $self->_declassify($i, $j);
            }
        }
    }


    sub clear {
        my ($self, $x, $y) = @_;
        $_-- for $x, $y;
        return unless $self->_validate($x, $y);
        return unless '.' eq $self->[$x][$y][SHOW];

        print "You lost.\n" and $self->end if 'm' eq $self->[$x][$y][REAL];

        $self->_declassify($x, $y);
    }


    sub remain {
        my ($self) = @_;
        my $unclear = 0;
        for my $column (@$self) {
            for my $cell (@$column) {
                $unclear++ if '.' eq $cell->[SHOW];
            }
        }
        return $unclear
    }

}

sub help {
    print << '__HELP__';
Commands:
h     ... help
q     ... quit
m X Y ... mark/unmark X Y
c X Y ... clear X Y
__HELP__
}


my ($width, $height, $percent) = @ARGV;
$width   ||= 6;
$height  ||= 4;
$percent ||= 15;

my $field = 'Local::Field'->new($width, $height, $percent);

my $help = 1;
while (1) {
    $field->show;
    help() if $help;
    $help = 0;
    my $remain = $field->remain;
    last if 0 == $remain;
    print "Cells remaining: $remain.\n";
    my $command = <STDIN>;
    exit if $command =~ /^q/i;

    if ($command =~ /^m.*?([0-9]+).*?([0-9]+)/i) {
        $field->mark($1, $2);

    } elsif ($command =~ /^c.*?([0-9]+).*?([0-9]+)/i) {
        $field->clear($1, $2);

    } elsif ($command =~ /^h/i) {
        $help = 1;

    } else {
        print "Huh?\n";
    }
}
print "You won!\n";
