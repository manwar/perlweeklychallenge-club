MODULE Ch1 EXPORTS Main;

IMPORT SIO,Text;

PROCEDURE CheckColor(READONLY Str:TEXT):BOOLEAN =
  BEGIN
    <* ASSERT Text.Length(Str) = 2 *>
    RETURN (ORD(Text.GetChar(Str,0)) +
           ORD(Text.GetChar(Str,1))) MOD 2 = 1
  END CheckColor;
  
BEGIN
  SIO.PutBool(CheckColor("d3")); SIO.Nl();
  SIO.PutBool(CheckColor("g5")); SIO.Nl();
  SIO.PutBool(CheckColor("e6")); SIO.Nl()
END Ch1.

