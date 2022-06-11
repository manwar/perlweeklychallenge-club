Program XXX;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-147 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out *)
(*                                           *)

var
    todo: array of integer;
    new_todo: array of integer;
    pow, i, d: integer;
    count: integer = 20;
    candidate: integer;

function is_prime (p: integer): boolean;
    var
        i: integer;

    begin
        if p = 2 then begin
            is_prime := true;
            exit;
        end;
        if p mod 2 = 0 then begin
            is_prime := false;
            exit;
        end;
        i := 3;
        while i * i <= p do begin
            if p mod i = 0 then begin
                is_prime := false;
                exit;
            end;
            i := i + 2;
        end;
        is_prime := true;
        exit;
    end;
    

begin
    setlength (todo, 4);
    todo [0] := 2;
    todo [1] := 3;
    todo [2] := 5;
    todo [3] := 7;
    for i := 0 to 3 do begin
        write (todo [i], ' ');
    end;
    count := count - 4;
    pow   := 10;
    while count > 0 do begin
        setlength (new_todo, 0);
        for d := 1 to 9 do begin
            for i := 0 to length (todo) - 1 do begin
                candidate := d * pow + todo [i];
                if is_prime (candidate) then begin
                    insert (candidate, new_todo, length (new_todo));
                    write (candidate, ' ');
                    count := count - 1;
                    if count <= 0 then begin
                        break;
                    end;
                end;
                if count <= 0 then begin
                    break;
                end;
            end;
            if count <= 0 then begin
                break;
            end;
        end;
        todo := new_todo;
        pow  := pow * 10;
    end;
    writeln ('');
end.

end.
