#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub lucky_numbers($m) {
    my @lucky;
    for my $row (@$m) {
        my $max_index = 0;
        for my $i (1 .. $#$row) {
            $max_index = $i if $row->[$i] < $row->[$max_index];
        }
        push @lucky, $row->[$max_index]
            if $row->[$max_index] == max(map $_->[$max_index], @$m);
    }
    return $lucky[0] if 1 == @lucky;
    return -1
}

use Test::More tests => 3 + 1;

is lucky_numbers([[ 3,  7,  8],
                  [ 9, 11, 13],
                  [15, 16, 17]]), 15, 'Example 1';

is lucky_numbers([[ 1, 10,  4,  2],
                  [ 9,  3,  8,  7],
                  [15, 16, 17, 12]]), 12, 'Example 2';

is lucky_numbers([[7 ,8],
                  [1 ,2] ]), 7, 'Example 3';

is lucky_numbers([[5, 3], [2, 4]]), -1, 'No lucky number';

=begin latex

=encoding UTF-8

\documentclass{article}
\newenvironment{theorem}{\par\textbf{Theorem:}\it}{\rm}
\newenvironment{proof}{\par\textbf{Proof:}}{\par{}\texttt{QED}\par}
\title{The Weekly Challenge 251 Task 2}
\author{E. Choroba}
\date{}
\begin{document}
\maketitle
\begin{theorem}
There can’t be more than 1 lucky number in a matrix.
\end{theorem}

\begin{proof}
Let’s say there are 2 different lucky numbers in the matrix, let’s
call them $l_1$ and $l_2$. They can also be written with matrix
coordinates as $m[i_1, j_1]$ and $m[i_2, j_2]$, respectivelly. Because
$l_1$ is a lucky number, we know that
$$
\forall x: m[i_1,x] \ge l_1 \quad(1)
$$
and
$$
\forall y: m[y, j_1] \le l_1 \quad(2)
$$

Similarly, for $l_2$ we have
$$
\forall x: m[i_2,x] \ge l_2 \quad(3)
$$
and
$$
\forall y: m[y, j_2] \le l_2 \quad(4)
$$

WLOG $l_1 < l_2$. Putting it together with (2) and (3):
$$
\forall x \forall y: m[y, j_1] \le l_1 < l2 \le m[i_2, x]
$$

As this formula holds for any $x$ and $y$, let’s select $x = j_1$ and
$y = i_2$.
$$
m[i_2, j_1] \le l1 < l2 \le m[i_2, j_1]
$$

It leads to the final inequality
$$
m[i_2, j_1] < m[i_2, j_1]
$$
which is clearly a \textit{contradiction}.

\end{proof}
\end{document}

=cut
