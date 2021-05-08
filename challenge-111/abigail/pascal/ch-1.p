Program SearchMatrix;

(*                  *)
(* See ../README.md *)
(*                  *)

(*                                                        *)
(* Run as: fpc -och-1.out ch-1.p; ./ch-1.out < input-file *)
(*                                                        *)

const
    matrix_size = 5;

type
    matrix_type = Array [1 .. matrix_size * matrix_size] of Longint;

var
    matrix:     matrix_type;
    var i:      Integer;
    var target: Longint;

(*                                                *)
(* Use binary search to find 'target' in 'matrix' *)
(*                                                *)
function bsearch (matrix: matrix_type; target: Longint) : Integer;
    var
        min, mid, max: Integer;
    begin
        bsearch := 0;
        min     := 1;
        max     := matrix_size * matrix_size + 1;
        while min < max do
        begin
            mid := (min + max) div 2;
            if matrix [mid] = target then
            begin
                bsearch := 1;
                min     := max;
            end;
            if matrix [mid] < target then
            begin
                min     := mid + 1;
            end
            else begin
                max     := mid - 1;
            end
        end
    end;


begin
    (* Read in the matrix *)
    for i := 1 to matrix_size * matrix_size do
    begin
        read (matrix [i]);
    end;

    (* The rest of the input are numbers we want to search *)
    while not eof () do
    begin
        readln  (target);
        writeln (bsearch (matrix, target));
    end;
end.
