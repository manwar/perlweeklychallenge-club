%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
%

%
% Run as: ln ch-1.erl ch1.erl
%         erl -compile ch1
%         erl -noshell -s ch1 main -s init stop
%

-module (ch1).
-export ([main/0]).

main () ->
    io:fwrite ("2 4 6 30 32 34 36 40 42 44 46 50 52 54 56 60 62 64 66\n").
