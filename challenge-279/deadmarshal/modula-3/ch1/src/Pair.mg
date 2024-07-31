GENERIC MODULE Pair(E1,E2);

IMPORT Word;

REVEAL T = BRANDED REF RECORD
  First:E1.T;
  Second:E2.T;
END;

PROCEDURE Create(READONLY First:E1.T;
                 READONLY Second:E2.T):T =
  BEGIN
    RETURN NEW(T,First := First,Second := Second)
  END Create;
  
PROCEDURE First(READONLY Pair:T):E1.T =
  BEGIN
    RETURN Pair.First
  END First;
  
PROCEDURE Second(READONLY Pair:T):E2.T =
  BEGIN
    RETURN Pair.Second
  END Second;

PROCEDURE Equal(READONLY a,b:T):BOOLEAN =
  BEGIN
    RETURN E1.Equal(a.First,b.First) AND E2.Equal(a.Second,b.Second)
  END Equal;
  
PROCEDURE Hash(READONLY a:T):Word.T =
  BEGIN
    RETURN E1.Hash(a.First)
  END Hash;
  
PROCEDURE Compare(READONLY a,b:T):[-1..1] =
BEGIN
  IF E1.Compare(a.First,b.First) < 0 AND
    E2.Compare(a.Second,b.Second) < 0 THEN RETURN -1
  ELSIF E1.Compare(a.First,b.First) > 0 AND
    E2.Compare(a.Second,b.Second) > 0 THEN RETURN 1
  ELSE RETURN 0
  END;
  END Compare;
  
BEGIN
END Pair.

