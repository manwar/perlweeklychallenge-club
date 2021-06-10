Program OrderedLetters;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out < input-file *)
(*                                                        *)

uses sysutils;

var
    line, longest: string;
    ch, prev_ch:   char;
    valid:         boolean;

begin
    longest := '';
    while not eof () do
    begin
        readln (line);
        valid   := true;
        prev_ch := ' ';   (* Any char less than 'a' will do *)

        (* Iterate over the characters of the lowercased string;        *)
        (* if the character isn't a lowercase letter, or the character  *)
        (* is less than the previous, it's not a valid candidate.       *)
        for ch in lowercase (line) do
        begin
            if (ch < 'a') or (ch > 'z') or (ch < prev_ch) then
            begin
                valid := false;
                break;
            end;
            prev_ch := ch;
        end;
        if valid and (length (line) > length (longest)) then
        begin
            longest := line;
        end;
    end;
    writeln (longest);
end.
