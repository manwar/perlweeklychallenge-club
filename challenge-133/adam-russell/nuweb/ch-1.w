\documentclass{article}

\usepackage{listings}
\lstset{extendedchars=true , keepspaces=true , language=perl}

\begin{document}

Challenge 133

\section{Integer Square Root}

You are given a positive integer \$N.
Write a script to calculate the integer square root of the given number.
Please avoid using built-in function.

@o perl/ch-1.pl 
@{
    @<preamble...@>
    @<nth root@>
    @<square root@>
    @<main@>
@}

@d preamble: use statements, introductory comments, etc.
@{
    use strict;
    use warnings;
@}

@d nth root
@{
    sub nth_root{
        my($n, $k) = @@_;
        my $x_i = int(rand(10) + 1); 
        my $r;
        for my $i (0 .. 100){
            $x_i = (1 / $n) * (($n - 1) * $x_i + ($k / $x_i ** ($n - 1)));  
        } 
        return $x_i;  
    }
@}

@d square root
@{
    sub integer_square_root{
        my($k) = @@_;
        my $x = int(nth_root(2, $k));
        return $x;  
    }
@}

@d main
@{
    MAIN:{
        print integer_square_root(10) . "\n";
        print integer_square_root(27) . "\n";
        print integer_square_root(85) . "\n";
        print integer_square_root(101) . "\n";
    }

@}

\end{document}
