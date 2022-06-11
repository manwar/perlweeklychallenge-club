%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-155
%

%
% Run as: ln ch-2.erl ch2.erl
%         erl -compile ch2
%         erl -noshell -s ch2 main -s init stop
%

-module (ch2).
-export ([main/0]).

main () ->
    io:fwrite ("8\n").
