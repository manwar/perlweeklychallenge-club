MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

TYPE
  ARef = REF ARRAY OF INTEGER;
  
VAR
  A1 := ARRAY[0..4] OF TEXT{"10","0001","111001","1","0"};
  A2 := ARRAY[0..2] OF TEXT{"10","1","0"};

PROCEDURE OnesAndZeros(VAR A:ARRAY OF TEXT;
                       READONLY X,Y:INTEGER):INTEGER =
  VAR
    F := NEW(REF ARRAY OF ARRAY OF INTEGER,X+1,Y+1);
    Cnt:ARef;
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      Cnt := Count(A[I]);
      FOR J := X TO Cnt[0] BY -1 DO
        FOR K := Y TO Cnt[1] BY -1 DO
         F[J,K] := MAX(F[J][K],F[J-Cnt[0],K-Cnt[1]]+1) 
        END
      END
    END;
    RETURN F[X][Y]
  END OnesAndZeros;

PROCEDURE Count(READONLY S:TEXT):ARef =
  VAR Cnt := NEW(ARef,2);
  BEGIN
    FOR I := 0 TO Text.Length(S)-1 DO
      INC(Cnt[ORD(Text.GetChar(S,I)) - ORD('0')])
    END;
    RETURN Cnt
  END Count;

BEGIN
  SIO.PutInt(OnesAndZeros(A1,5,3)); SIO.Nl();
  SIO.PutInt(OnesAndZeros(A2,1,1)); SIO.Nl()
END Ch1.

