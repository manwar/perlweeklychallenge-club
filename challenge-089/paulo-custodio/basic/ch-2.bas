' Challenge 089
'
' TASK #2 › Magical Matrix
' Submitted by: Mohammad S Anwar
' Write a script to display matrix as below with numbers 1 - 9.
' Please make sure numbers are used once.
'
' [ a b c ]
' [ d e f ]
' [ g h i ]
' So that it satisfies the following:
'
' a + b + c = 15
' d + e + f = 15
' g + h + i = 15
' a + d + g = 15
' b + e + h = 15
' c + f + i = 15
' a + e + i = 15
' c + e + g = 15

' Brute force solution in Basic

Sub solve()
  Dim a as Integer, b as Integer, c as Integer, d as Integer
  Dim e as Integer, f as Integer, g as Integer, h as Integer, i as Integer
  For a=1 To 9
    For b=1 To 9
      If b<>a Then
        For c=1 To 9
          If c<>a AndAlso c<>b Then
            For d=1 To 9
              If d<>a AndAlso d<>b AndAlso d<>c Then
                For e=1 To 9
                  If e<>a AndAlso e<>b AndAlso e<>c AndAlso e<>d Then
                    For f=1 To 9
                      If f<>a AndAlso f<>b AndAlso f<>c AndAlso f<>d AndAlso f<>e Then
                        For g=1 To 9
                          If g<>a AndAlso g<>b AndAlso g<>c AndAlso g<>d AndAlso _
                             g<>e AndAlso g<>f Then
                            For h=1 To 9
                              If h<>a AndAlso h<>b AndAlso h<>c AndAlso h<>d AndAlso _
                                 h<>e AndAlso h<>f AndAlso h<>g Then
                                For i=1 To 9
                                  If i<>a AndAlso i<>b AndAlso i<>c AndAlso _
                                     i<>d AndAlso i<>e AndAlso i<>f AndAlso _
                                     i<>g AndAlso i<>h Then
                                    If a + b + c = 15 AndAlso _
                                       d + e + f = 15 AndAlso _
                                       g + h + i = 15 AndAlso _
                                       a + d + g = 15 AndAlso _
                                       b + e + h = 15 AndAlso _
                                       c + f + i = 15 AndAlso _
                                       a + e + i = 15 AndAlso _
                                       c + e + g = 15 Then
                                      Print "[";a;b;c;" ]"
                                      Print "[";d;e;f;" ]"
                                      Print "[";g;h;i;" ]"
                                      Exit Sub
                                    EndIf
                                  EndIf
                                Next i
                              EndIf
                            Next h
                          EndIf
                        Next g
                      EndIf
                    Next f
                  EndIf
                Next e
              EndIf
            Next d
          EndIf
        Next c
      EndIf
    Next b
  Next a
End Sub

solve
