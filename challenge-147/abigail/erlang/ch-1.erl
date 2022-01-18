%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
%

%
% Run as: ln ch-1.erl ch1.erl
%         erl -compile ch1
%         erl -noshell -s ch1 main -s init stop
%

-module (ch1).
-export ([main/0]).

main () ->
    io:fwrite ("2 3 5 7 13 17 23 37 43 47 53 67 73 83 97 113 137 167 173 197\n").