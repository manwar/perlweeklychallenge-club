GENERIC INTERFACE Pair(E1,E2);

IMPORT Word;

CONST
  Brand = "Pair(" & E1.Brand & "," & E2.Brand & ")";

TYPE
  T <: REFANY;
  
PROCEDURE Create(READONLY First:E1.T;
                 READONLY Second:E2.T):T;
PROCEDURE Equal(READONLY a,b:T):BOOLEAN;
PROCEDURE Hash(READONLY a:T):Word.T;
PROCEDURE Compare(READONLY a,b:T):[-1..1];
PROCEDURE First(READONLY Pair:T):E1.T;
PROCEDURE Second(READONLY Pair:T):E2.T;

END Pair.

