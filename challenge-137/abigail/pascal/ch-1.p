Program XXX;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

const
    nr_of_start_years =    2;
    nr_of_offsets     =   71;
    first_year        = 1900;
    last_year         = 2100;

var
    start_years:       Array [1 .. nr_of_start_years] of Integer = (
        1600, 2000
    );
    long_year_offsets: Array [1 .. nr_of_offsets]     of Integer = (
          4,      9,     15,     20,     26,
         32,     37,     43,     48,     54,
         60,     65,     71,     76,     82,
         88,     93,     99,            
                105,    111,    116,    122,
        128,    133,    139,    144,    150,
        156,    161,    167,    172,    178,
        184,    189,    195,            
                201,    207,    212,    218,
        224,    229,    235,    240,    246,
        252,    257,    263,    268,    274,
        280,    285,    291,    296,    
                        303,    308,    314,
        320,    325,    331,    336,    342,
        348,    353,    359,    364,    370,
        376,    381,    387,    392,    398
    );
    year: Integer;
    i, j: Integer;

begin
    for i := 1 to nr_of_start_years do begin
        for j := 1 to nr_of_offsets do begin
            year := start_years [i] + long_year_offsets [j];
            if (first_year <= year) and (year <= last_year)
            then begin
                writeln (year)
            end
        end
    end
end.
