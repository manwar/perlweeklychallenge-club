MODULE Ch2 EXPORTS Main;

IMPORT SIO;

PROCEDURE MakingChange(READONLY A:CARDINAL):CARDINAL =
  VAR
    Coins:ARRAY[0..4] OF CARDINAL := ARRAY[0..4] OF CARDINAL{1,5,10,25,50};
    DP:REF ARRAY OF CARDINAL := NEW(REF ARRAY OF CARDINAL,A+1);
  BEGIN
    DP[0] := 1;
    FOR I := FIRST(Coins) TO LAST(Coins) DO
      FOR J := Coins[I] TO A DO INC(DP[J],DP[J-Coins[I]]) END
    END;
    RETURN DP[A]
  END MakingChange;
  
BEGIN
  SIO.PutInt(MakingChange(9)); SIO.Nl();
  SIO.PutInt(MakingChange(15)); SIO.Nl();
  SIO.PutInt(MakingChange(100)); SIO.Nl()
END Ch2.

