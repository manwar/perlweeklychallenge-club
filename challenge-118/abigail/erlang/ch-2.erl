%
% See ../README.md
%

%
% Run as: ln ch-2.erl ch2.erl
%         erl -compile ch2
%         erl -noshell -s ch2 main -s init stop
%

-module (ch2).
-export ([main/0]).

main () ->
    io:fwrite ("a8 c7 e6 c5 b3 c1 a2 c3 b1 a3 c4 b2\n").
