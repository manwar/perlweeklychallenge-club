Program ch2;

(*                                                                   *)
(* See https://theweeklychallenge.org/blog/perl-weekly-challenge-147 *)
(*                                                                   *)

(*                                           *)
(* Run as: fpc -och-2.out ch-2.p; ./ch-2.out *)
(*                                           *)

uses
    fgl;

var
    pentagon: specialize TFPGMap <longint, boolean>;
    n, p, seen, i: longint;
    done: boolean;

begin
    pentagon := specialize TFPGMap <longint, boolean> . Create;
    p := 0;
    n := 0;
    done := false;
    while not done do begin
        p := p + n + n + n + 1;
        n := n + 1;
        pentagon . Add (p, true);
        for i := 0 to pentagon . count - 1 do begin
            seen := pentagon . Keys [i];
            if (seen + seen <= p)                    and
               (pentagon . IndexOf (p - seen) >= 0)  and
               (pentagon . IndexOf (p - seen - seen) >= 0) then begin
                writeln (seen, ' ', p - seen);
                done := true;
            end;
            if done then begin
                break;
            end;
        end
    end
end.
