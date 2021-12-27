Program ch2;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses
    StrUtils, fgl;

var
    line: string;
    i, j: integer;
    substr: string;
    palindromes: specialize TFPGMap <string, boolean>;

begin
    while not eof do begin
        palindromes := specialize TFPGMap <string, boolean> . Create;
        readln (line);
        for i := 1 to length (line) do begin
            for j := i to length (line) do begin
                substr := copy (line, i, j - i + 1);
                if substr = ReverseString (substr) then begin
                    if palindromes . IndexOf (substr) = -1 then begin
                        write (substr, ' ');
                        palindromes . Add (substr, true);
                    end
                end
            end
        end;
        writeln ('');
        palindromes . Free;
    end
end.
