Program ch1;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-154 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    fgl;

var
    word: string;
    p1: array [1 .. 24] of string =
              ('PERL', 'PELR', 'PREL', 'PRLE', 'PLER', 'PLRE',
               'EPRL', 'EPLR', 'ERPL', 'ERLP', 'ELPR', 'ELRP',
               'REPL', 'RELP', 'RPEL', 'RPLE', 'RLEP', 'RLPE',
               'LERP', 'LEPR', 'LREP', 'LRPE', 'LPER', 'LPRE');
    p: specialize TFPGMap <string, integer>;
    i: integer;

begin
    p := specialize TFPGMap <string, integer> . Create;
    for i := 1 to 24 do begin
        p . Add (p1 [i], 1)
    end;

    while not eof do begin
        readln (word);
        p . Remove (word);
    end;

    for i := 1 to 24 do begin
        if p . IndexOf (p1 [i]) > -1 then begin
            writeln (p1 [i]);
        end;
    end;
end.
