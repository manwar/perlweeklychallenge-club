MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE BuddyStrings(READONLY S1,S2:TEXT):BOOLEAN =
  VAR
    Flag := FALSE;
    Diff:CARDINAL := 0;
    Count1,Count2 := ARRAY[0..25] OF CARDINAL{0,..};
  BEGIN
    IF Text.Length(S1) # Text.Length(S2) THEN RETURN FALSE END;
    FOR I := 0 TO Text.Length(S1)-1 DO
      WITH A = Text.GetChar(S1,I),B = Text.GetChar(S2,I) DO
        INC(Count1[ORD(A)-ORD('a')]);
        INC(Count2[ORD(B)-ORD('a')]);
        IF A # B THEN INC(Diff) END
      END
    END;
    FOR I := FIRST(Count1) TO LAST(Count1) DO
      IF Count1[I] # Count2[I] THEN RETURN FALSE END;
      IF Count1[I] > 1 THEN Flag := TRUE END
    END;
    RETURN Diff = 2 OR Diff = 0 AND Flag
  END BuddyStrings;

BEGIN
  SIO.PutBool(BuddyStrings("fuck","fcuk")); SIO.Nl();
  SIO.PutBool(BuddyStrings("love","love")); SIO.Nl();
  SIO.PutBool(BuddyStrings("fodo","food")); SIO.Nl();
  SIO.PutBool(BuddyStrings("feed","feed")); SIO.Nl()
END Ch2.

