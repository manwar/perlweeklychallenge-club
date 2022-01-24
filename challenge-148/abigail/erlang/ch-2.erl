%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
%

%
% Run as: ln ch-2.erl ch2.erl
%         erl -compile ch2
%         erl -noshell -s ch2 main -s init stop
%

-module (ch2).
-export ([main/0]).

main () ->
    io:fwrite ("2 1 5\n5 2 13\n8 3 21\n17 18 5\n11 4 29\n").
