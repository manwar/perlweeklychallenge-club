MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE EqualStrings(READONLY S1,S2,S3:TEXT):INTEGER =
  VAR
    Sum := Text.Length(S1) + Text.Length(S2) + Text.Length(S3);
    N := MIN(MIN(Text.Length(S1),Text.Length(S2)),Text.Length(S3));
  BEGIN
    FOR I := 0 TO N-1 DO
      IF NOT (Text.GetChar(S1,I) = Text.GetChar(S2,I) AND
        Text.GetChar(S2,I) = Text.GetChar(S3,I)) THEN
        IF I = 0 THEN RETURN -1 ELSE RETURN Sum - 3 * I END
      END
    END;
    RETURN Sum - 3 * N
  END EqualStrings;

BEGIN
  SIO.PutInt(EqualStrings("abc","abb","ab")); SIO.Nl();
  SIO.PutInt(EqualStrings("ayz","cyz","xyz")); SIO.Nl();
  SIO.PutInt(EqualStrings("yza","yzb","yzc")); SIO.Nl()
END Ch1.

