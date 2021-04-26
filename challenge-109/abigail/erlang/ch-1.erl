%
% See ../README.md
%

%
% Run as: ln ch-1.erl ch1.erl
%         erl -compile ch1
%         erl -noshell -s ch1 main -s init stop
%

-module (ch1).
-export ([main/0]).

main () ->
    io:fwrite ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21\n").
