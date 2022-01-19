Program ch1;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-001 *)
(*                                                                   *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

uses
    StrUtils, SysUtils;

var
    line: string;
    count: LongInt;

begin
    while not eof do begin
        readln (line);
        count := 0;
        line := StringReplace (line, 'e', 'E', [rfReplaceAll], count);
        writeln (line);
        writeln (count);
    end
end.
