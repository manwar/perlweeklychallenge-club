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


long_year ([], _) -> ok;
long_year (_, []) -> ok;

long_year ([Start], [Offset | Offsets]) ->
    Year = Start + Offset,
    if (1900 =< Year) and (Year =< 2100) -> io:fwrite ("~B~n", [Year]);
        true -> ok
    end,
    long_year ([Start], Offsets);

long_year ([Start | Starts], Offsets) ->
    long_year ([Start], Offsets),
    long_year (Starts, Offsets).

main () ->
    Start_years       = [1600, 2000],
    Long_year_offsets = [
          4,   9,  15,  20,  26,  32,  37,  43,  48,  54,
         60,  65,  71,  76,  82,  88,  93,  99,      
             105, 111, 116, 122, 128, 133, 139, 144, 150,
        156, 161, 167, 172, 178, 184, 189, 195,      
             201, 207, 212, 218, 224, 229, 235, 240, 246,
        252, 257, 263, 268, 274, 280, 285, 291, 296, 
                  303, 308, 314, 320, 325, 331, 336, 342,
        348, 353, 359, 364, 370, 376, 381, 387, 392, 398
    ],
    long_year (Start_years, Long_year_offsets).
