MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

VAR
  A1 := ARRAY[0..2] OF TEXT{"Perl","Weekly","Challenge"};
  A2 := ARRAY[0..2] OF TEXT{"Bob","Charlie","Joe"};
  A3 := ARRAY[0..1] OF TEXT{"Morning","Good"};
  
PROCEDURE Acronyms(VAR A:ARRAY OF TEXT;READONLY S:TEXT):BOOLEAN =
  VAR Temp:TEXT := "";
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      Temp := Temp & Text.FromChar(Text.GetChar(A[I],0))
    END;
    RETURN Text.Equal(Temp,S)
  END Acronyms;
  
BEGIN
  SIO.PutBool(Acronyms(A1,"PWC")); SIO.Nl();
  SIO.PutBool(Acronyms(A2,"BCJ")); SIO.Nl();
  SIO.PutBool(Acronyms(A3,"MM")); SIO.Nl()
END Ch1.

