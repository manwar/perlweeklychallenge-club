Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-002 *)
(*                                                                   *)

(*                                                                   *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out [-f | -t] < input-file  *)
(*                                                                   *)

uses
    strutils;

var
    line: string;
    num: longint;
    to_base, from_base: boolean;

begin
    if paramCount () = 1 then begin
        if paramStr (1) = '-f' then begin
            from_base := true;
        end;
        if paramStr (1) = '-t' then begin
            to_base := true;
        end
    end;
    while not eof do begin
        if to_base then begin
            readln (num);
            writeln (Dec2Numb (num, 1, 35));
        end;
        if from_base then begin
            readln (line);
            writeln (Numb2Dec (line, 35));
        end
    end
end.
