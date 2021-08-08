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
    io:fwrite ("    ^^^^^\n"),
    io:fwrite ("   ^     ^\n"),
    io:fwrite ("  ^       ^\n"),
    io:fwrite (" ^         ^\n"),
    io:fwrite (" ^         ^\n"),
    io:fwrite (" ^         ^\n"),
    io:fwrite (" ^         ^\n"),
    io:fwrite (" ^         ^\n"),
    io:fwrite ("  ^       ^\n"),
    io:fwrite ("   ^     ^\n"),
    io:fwrite ("    ^^^^^\n"),
    io:fwrite ("      ^\n"),
    io:fwrite ("      ^\n"),
    io:fwrite ("      ^\n"),
    io:fwrite ("    ^^^^^\n"),
    io:fwrite ("      ^\n"),
    io:fwrite ("      ^\n").