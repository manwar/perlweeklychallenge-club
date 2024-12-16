
Program Ch1;

{$mode objfpc}{$H+}{$J-}

Uses Types, strutils, sysutils;

Function replaceWords(Const Sentence: String; words: TStringDynArray): String;

Var 
  splitSentence: TStringDynArray;
  s, w: String;
  notFound: Boolean;
Begin
  Result := '';
  splitSentence := SplitString(sentence, ' ');
  For s In splitSentence Do
    Begin
      notFound := True;
      For w In words Do
        Begin
          If StartsStr(w, s) Then
            Begin
              Result := Result + w + ' ';
              notFound := False;
              break;
            End;
        End;
      If notFound Then
        Result := Result + s + ' ';
    End;
  Result := TrimRight(Result);
End;

Procedure checkString(expected, sentence: String; words: TStringDynArray);

Var 
  replaced: String;
Begin
  replaced := replaceWords(sentence, words);
  If expected = replaced Then
    writeln('Works for: "', sentence, '"')
  Else
    writeln('Did not work for: "', sentence, '"');
End;

Begin
  checkString('the cat was rat by the bat',
              'the cattle was rattle by the battery', ['cat', 'bat', 'rat']);
  checkString('a a a c b', 'aab aac and cac bab', ['a', 'b', 'c']);
  checkString('the man was hit by a bike', 'the manager was hit by a biker',
              ['man', 'bike']);
End.
