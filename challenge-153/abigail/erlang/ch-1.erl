%
% See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
%

%
% Run as: ln ch-1.erl ch1.erl
%         erl -compile ch1
%         erl -noshell -s ch1 main -s init stop
%

-module (ch1).
-export ([main/0]).

main () ->
    io:fwrite ("1 2 4 10 34 154 874 5914 46234 409114\n").
