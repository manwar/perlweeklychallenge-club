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
    io:fwrite ("4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95\n").