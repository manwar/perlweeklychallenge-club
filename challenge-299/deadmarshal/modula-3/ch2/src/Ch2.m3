MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

VAR
  Dir := ARRAY[0..3],[0..1] OF INTEGER{
  ARRAY[0..1] OF INTEGER{-1,0},
  ARRAY[0..1] OF INTEGER{0,1},
  ARRAY[0..1] OF INTEGER{1,0},
  ARRAY[0..1] OF INTEGER{0,-1}};
  A1 := ARRAY[0..3],[0..3] OF CHAR{
  ARRAY[0..3] OF CHAR{'A','B','D','E'},
  ARRAY[0..3] OF CHAR{'C','B','C','A'},
  ARRAY[0..3] OF CHAR{'B','A','A','D'},
  ARRAY[0..3] OF CHAR{'D','B','B','C'}};
  A2 := ARRAY[0..3],[0..3] OF CHAR{
  ARRAY[0..3] OF CHAR{'A','A','B','B'},
  ARRAY[0..3] OF CHAR{'C','C','B','A'},
  ARRAY[0..3] OF CHAR{'C','A','A','A'},
  ARRAY[0..3] OF CHAR{'B','B','B','B'}};
  A3 := ARRAY[0..3],[0..3] OF CHAR{
  ARRAY[0..3] OF CHAR{'B','A','B','A'},
  ARRAY[0..3] OF CHAR{'C','C','C','C'},
  ARRAY[0..3] OF CHAR{'A','B','A','B'},
  ARRAY[0..3] OF CHAR{'B','B','A','A'}};

PROCEDURE WordSearch(VAR Chars:ARRAY OF ARRAY OF CHAR;
                     READONLY Str:TEXT):BOOLEAN =
  VAR
    Visited := NEW(REF ARRAY OF ARRAY OF BOOLEAN,
                   NUMBER(Chars),
                   NUMBER(Chars[0]));
  BEGIN
    FOR I := FIRST(Chars) TO LAST(Chars) DO
      FOR J := FIRST(Chars[0]) TO LAST(Chars[0]) DO
        IF Helper(Chars,Visited^,Str,0,I,J) THEN RETURN TRUE END
      END
    END;
    RETURN FALSE
  END WordSearch;

PROCEDURE IsInside(VAR Chars:ARRAY OF ARRAY OF CHAR;
                   READONLY X,Y:INTEGER):BOOLEAN =
  BEGIN
    RETURN X >= 0 AND
    X < NUMBER(Chars) AND
    Y >= 0 AND
    Y < NUMBER(Chars[0])
  END IsInside;
  
PROCEDURE Helper(VAR Chars:ARRAY OF ARRAY OF CHAR;
                 VAR Visited:ARRAY OF ARRAY OF BOOLEAN;
                 READONLY Word:TEXT;
                 READONLY Index,X,Y:INTEGER):BOOLEAN =
  BEGIN
    IF Index = Text.Length(Word)-1 THEN
      RETURN Chars[X,Y] = Text.GetChar(Word,Index)
    END;
    IF Chars[X,Y] = Text.GetChar(Word,Index) THEN
      Visited[X,Y] := TRUE;
      FOR I := FIRST(Dir) TO LAST(Dir) DO
        WITH Nx = X + Dir[I,0], Ny = Y + Dir[I,1] DO
          IF IsInside(Chars,Nx,Ny) AND
            NOT Visited[Nx,Ny] AND
            Helper(Chars,Visited,Word,Index+1,Nx,Ny) THEN
            RETURN TRUE
          END
        END
      END;
      Visited[X,Y] := FALSE
    END;
    RETURN FALSE
  END Helper;
  
BEGIN
  SIO.PutBool(WordSearch(A1,"BDCA")); SIO.Nl();
  SIO.PutBool(WordSearch(A2,"ABAC")); SIO.Nl();
  SIO.PutBool(WordSearch(A3,"CCCAA")); SIO.Nl()
END Ch2.

