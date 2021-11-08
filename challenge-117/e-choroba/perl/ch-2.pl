#!/usr/bin/perl
use warnings;
use strict;
use feature qw { say };

use List::Util qw{ sum };

my %MOVE = (H => [1, 0],
            L => [0, 1],
            R => [1, 1]);

sub bfs_show {
    my ($size) = @_;
    my @paths =  (["", 0, 0]);
    while (my @moves = grep $_->[1] != $size || $_->[2] != $size, @paths) {
        my @next;
        for my $move (@moves) {
            for my $dir (keys %MOVE) {
                my $x = $move->[1] + $MOVE{$dir}[0];
                my $y = $move->[2] + $MOVE{$dir}[1];

                my $next_path = $move->[0] . $dir;
                if ($x == $size && $y == $size) {
                    say $next_path;
                } else {
                    push @next, [$next_path, $x, $y]
                        if $x <= $size && $y <= $size && $x <= $y;
                }
            }
        }
        @paths = @next;
    }
}

sub _dfs {
    my ($size, $x, $y, $path) = @_;
    return if $x > $size || $y > $size || $y < $x;

    say $path
        if $x == $size && $y == $size;

    _dfs($size, $x + $MOVE{$_}[0], $y + $MOVE{$_}[1],
                    "$path$_")
        for keys %MOVE
}

sub dfs_show {
    my ($size) = @_;
    _dfs($size, 0, 0, "");
}

sub fast { _fast($_[0] + 1) }

my %cache = (1 => 1);
sub _fast {
    my ($x) = @_;
    return $cache{$x} if exists $cache{$x};

    return $cache{$x} = _fast($x - 1)
        + sum(map _fast($_) * _fast($x - $_), 1 .. $x - 1)
}

if (@ARGV) {
    my %dispatch = (
        bfs => \&bfs_show,
        dfs => \&dfs_show,
    );
    my $code = $dispatch{+shift} or die "Unknown option";

    $code->(shift);
    exit;
}

use Test2::V0;

sub Bag { my @items = @_; bag { item $_ for @items; end } }

sub line_count {
    my (@run) = @_;
    open my $pipe, '-|', $0, @run or die $!;
    my $count = 0;
    ++$count while <$pipe>;
    return $count
}

sub output {
    my (@run) = @_;
    open my $pipe, '-|', $0, @run or die $!;
    chomp( my @lines = <$pipe> );
    return \@lines
}

is output(bfs => 1), Bag(qw( LH R )), 'bfs 1';
is output(bfs => 2), Bag(qw( RR LHR LHLH LLHH RLH LRH )), 'bfs 2';
is output(bfs => 3), Bag(qw( RRR RRLH LHRR LHRLH LHLHR LHLHLH LLHHR
                             LLHHLH RLHR RLHLH LRHR LRHLH LLLHHH LLRHH
                             LLHLHH LLHRH LHLRH LHLLHH
                             LRRH LRLHH RLRH RLLHH )),
    'bfs 3';
is line_count(bfs => 10), fast(10), 'count bfs 10';
# Out Of Memory.
# is line_count(bfs => 20), fast(20);

is output(dfs => 1), Bag(qw( LH R )), 'dfs 1';
is output(dfs => 2), Bag(qw( RR LHR LHLH LLHH RLH LRH )), 'dfs 2';
is output(dfs => 3), Bag(qw( RRR RRLH LHRR LHRLH LHLHR LHLHLH LLHHR
                             LLHHLH RLHR RLHLH LRHR LRHLH LLLHHH LLRHH
                             LLHLHH LLHRH LHLRH LHLLHH
                             LRRH LRLHH RLRH RLLHH )),
    'dfs 3';
is line_count(dfs => 10), fast(10), 'count bfs 10';
# Memory is fine, but would take more than 2 years.
# is line_count(dfs => 20), fast(20);

is fast(1), 2, 'fast 1';
is fast(2), 6, 'fast 2';
is fast(3), 22, 'fast 3';
is fast(4), 90, 'fast 4';
is fast(5), 394, 'fast 5';
is fast(6), 1806, 'fast 6';
is fast(10), 1037718, 'fast 10';
is fast(20), 17518619320890, 'fast 20';;

for my $x (1 .. 9) {
    is fast($x), line_count(dfs => $x), "fast - count dfs $x";
    is fast($x), line_count(bfs => $x), "fast - count bfs $x";
    is output(dfs => $x), Bag(@{ output(bfs => $x) }), "dfs - bfs $x" if $x < 7;
}

done_testing();

=head1 Find Possible Path

When I submitted the task, the final goal was specified differently: "Write a
function that takes the size of a triangle as the input and returns the number
of the possible paths. Can it find the results for 10 and 20?"

That's because I knew we could compute the number of possible paths for size
20, but it was almost impossible to list them all: there are more than C<10 **
13> of them.

I show three solutions here. C<bfs> and C<dfs> stand for Breadth-first-search
and Depth-first-search, respectively. They both print the paths instead of
returning them, it reduces their memory requirements.

If the script is run with parameters, the first parameter must be either
C<bfs> or C<dfs>, the second parameter should be the triangle size. When run
without parameters, the tests are run, running the script itself with various
parameter combinations.

The formula for the C<fast> subroutine was discovered in the L<On-line
Encyclopedia of Integer Sequences|https://oeis.org> which I searched for the
sequence of the first several line counts.

=cut
