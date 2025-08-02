MODULE Ch2 EXPORTS Main;

IMPORT SIO,Text,ASCII,Cell,CellSeq;

PROCEDURE IsInside(READONLY X,Y,N:INTEGER):BOOLEAN =
  BEGIN
    RETURN X >= 0 AND X <= N AND Y >= 0 AND Y <= N
  END IsInside;

PROCEDURE MinSteps(READONLY K1,K2,T1,T2,N:INTEGER):CARDINAL =
  VAR
    Dirs := ARRAY[0..7] OF Cell.T{
    Cell.T{-2,1},Cell.T{-1,2},
    Cell.T{1,2},Cell.T{2,1},
    Cell.T{2,-1},Cell.T{1,-2},
    Cell.T{-1,-2},Cell.T{-2,-1}};
    Q:CellSeq.T := NEW(CellSeq.T).init(NUMBER(Dirs)+1);
    Visited: REF ARRAY OF ARRAY OF BOOLEAN :=
        NEW(REF ARRAY OF ARRAY OF BOOLEAN,N+1,N+1);
    Temp:Cell.T;
    X,Y:INTEGER;
  BEGIN
    Q.addhi(Cell.T{K1,K2,0});
    WHILE Q.size() # 0 DO
      Temp := Q.remlo();
      IF Temp.X = T1 AND Temp.Y = T2 THEN RETURN Temp.D END;
      FOR I := FIRST(Dirs) TO LAST(Dirs) DO
        X := Temp.X + Dirs[I].X;
        Y := Temp.Y + Dirs[I].Y;
        IF IsInside(X,Y,N) AND NOT Visited[X,Y] THEN
          Visited[X][Y] := TRUE;
          Q.addhi(Cell.T{X,Y,Temp.D+1})
        END
      END
    END;
    RETURN LAST(INTEGER);
  END MinSteps;

PROCEDURE KnightsMoves(READONLY Start,End:TEXT):CARDINAL =
  BEGIN
    <* ASSERT Text.Length(Start) = 2 AND Text.Length(End) = 2
    AND Text.GetChar(Start,0) IN ASCII.Letters AND
    Text.GetChar(Start,1) IN ASCII.Digits AND
    Text.GetChar(End,0) IN ASCII.Letters AND
    Text.GetChar(End,1) IN ASCII.Digits *>
    RETURN MinSteps(ORD(Text.GetChar(Start,0)) - ORD('a'),
                    ORD(Text.GetChar(Start,1)) - ORD('0'),
                    ORD(Text.GetChar(End,0)) - ORD('a'),
                    ORD(Text.GetChar(End,1)) - ORD('0'),
                    8)
  END KnightsMoves;
  
BEGIN
  SIO.PutInt(KnightsMoves("g2","a8")); SIO.Nl();
  SIO.PutInt(KnightsMoves("g2","h2")); SIO.Nl()
END Ch2.

