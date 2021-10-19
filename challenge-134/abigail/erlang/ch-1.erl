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

pandigital ([])            -> ok;
pandigital ([Head | List]) ->
    io:fwrite ("1023456~w~n", [Head]),
    pandigital (List).
    

main () ->
    pandigital ([789, 798, 879, 897, 978]).

