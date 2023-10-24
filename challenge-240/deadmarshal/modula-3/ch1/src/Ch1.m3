MODULE Ch1 EXPORTS Main;

IMPORT SIO,IO,Text,ASCII;

VAR
  A1:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"Perl", "Python", "Pascal"};
  A2:ARRAY[0..1] OF TEXT := ARRAY OF TEXT{"Perl", "Raku"};
  A3:ARRAY[0..2] OF TEXT := ARRAY OF TEXT{"Oracle", "Awk", "C"};
  
PROCEDURE Acronym(VAR A:ARRAY OF TEXT;Check:TEXT):BOOLEAN =
  VAR T:TEXT := "";
  BEGIN
    FOR I := FIRST(A) TO LAST(A) DO
      T := T & Text.FromChar(ASCII.Lower[Text.GetChar(A[I],0)])
    END;
    RETURN Text.Equal(T,Check)
  END Acronym;
  
BEGIN
  SIO.PutBool(Acronym(A1,"ppp")); IO.Put("\n");
  SIO.PutBool(Acronym(A2,"rp")); IO.Put("\n");
  SIO.PutBool(Acronym(A3,"oac")); IO.Put("\n"); 
END Ch1.

