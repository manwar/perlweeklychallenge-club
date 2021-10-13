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

func ([])    -> ok;
func ([H|T]) ->
    io:fwrite ("1023456~w~n", [H]),
    func (T).
    

main () ->
    func ([789, 798, 879, 897, 978]).

