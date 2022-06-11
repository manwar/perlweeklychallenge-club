%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
%

%
% Run as: ln ch-2.erl ch2.erl
%         erl -compile ch2
%         erl -noshell -s ch2 main -s init stop
%

-module (ch2).
-export ([main/0]).

main () ->
    io:fwrite ("2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057\n").
