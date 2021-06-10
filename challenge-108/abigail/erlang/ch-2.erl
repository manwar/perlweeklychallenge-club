%
% See ../README.md
%

%
% Run as: ln ch-2.erl ch2.erl
%         erl -compile ch2
%         erl -noshell -s ch1 main -s init stop
%

-module (ch2).
-export ([main/0]).

main () ->
    io:fwrite ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147\n").
