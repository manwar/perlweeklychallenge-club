MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,TextArraySort;

VAR
  A1 := ARRAY[0..2] OF TEXT{"perl","python","raku"};
  A2 := ARRAY[0..2] OF TEXT{"the","weekly","challenge"};
  C1 := ARRAY[0..25] OF CHAR{'h','l','a','b','y','d','e','f','g','i',
                             'r','k','m','n','o','p','q','j','s','t',
                             'u','v','w','x','c','z'};
  C2 := ARRAY[0..25] OF CHAR{'c','o','r','l','d','a','b','t','e','f',
                             'g','h','i','j','k','m','n','p','q','s',
                             'w','u','v','x','y','z'};
  
PROCEDURE AlienDictionary(VAR A:ARRAY OF TEXT;
                          VAR Alien:ARRAY OF CHAR) =
  PROCEDURE Translate(READONLY Str:TEXT;
                    VAR Alien:ARRAY OF CHAR):TEXT =
  VAR Ret := NEW(REF ARRAY OF CHAR,Text.Length(Str));
  BEGIN
    FOR I := 0 TO Text.Length(Str)-1 DO
      Ret[I] := Alien[ORD(Text.GetChar(Str,I)) - ORD('a')]
    END;
    RETURN Text.FromChars(Ret^)
  END Translate;
  PROCEDURE Compare(A,B:TEXT):[-1..1] =
  BEGIN
    RETURN Text.Compare(Translate(A,Alien),Translate(B,Alien))
  END Compare;
  BEGIN
    TextArraySort.Sort(A,Compare)
  END AlienDictionary;

PROCEDURE PrintArray(VAR A:ARRAY OF TEXT) =
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      SIO.PutText(A[I]);
      SIO.PutChar(' ')
    END;
    SIO.Nl()
  END PrintArray;
  
BEGIN
  AlienDictionary(A1,C1);
  AlienDictionary(A2,C2);
  PrintArray(A1);
  PrintArray(A2)
END Ch2.

