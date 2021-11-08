Attribute VB_Name = "ModTask_02"
Option Explicit
Option Base 1

Sub Task_02()

    ''Credits
    ''https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-131/ulrich-rieke/cpp/ch-2.cpp
    ''https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-131/ulrich-rieke/perl/ch-2.pl
    ''https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-131/ziameraj16/java/FindPairs.java

    Dim strMsg As String
    Dim strDelim As String, strToFind As String
    Dim strOpenDelim As String, strCloseDelim As String
    Dim strOpenSet As String, strCloseSet As String
    Dim nLoop As Integer, nIndxFind As Integer
    Dim wsFunc As Object
    
    Set wsFunc = Application.WorksheetFunction
    
    ''Example 1:
    ''strDelim = """" & """" & "[]()"
    ''strToFind = """" & "I like (parens) and the Apple ][+" & """" & " they said."
    
    ''Example 2:
    strDelim = "**//<>"
    strToFind = "/* This is a comment (in some languages) */ <could be a tag>"
    
    For nLoop = 1 To Len(strDelim)
        If nLoop Mod 2 = 0 Then
            strOpenDelim = strOpenDelim & Mid(strDelim, nLoop, 1)
        Else
            strCloseDelim = strCloseDelim & Mid(strDelim, nLoop, 1)
        End If
    Next nLoop
    
    For nLoop = 1 To Len(strToFind)
        
        ''Open Set
        nIndxFind = 0
        On Error Resume Next
        nIndxFind = wsFunc.Find(Mid(strToFind, nLoop, 1), strOpenDelim)
        On Error GoTo 0
        If nIndxFind > 0 Then
            strOpenSet = strOpenSet & Mid(strToFind, nLoop, 1)
        End If
        ''Open Set
        
        ''Close Set
        nIndxFind = 0
        On Error Resume Next
        nIndxFind = wsFunc.Find(Mid(strToFind, nLoop, 1), strCloseDelim)
        On Error GoTo 0
        If nIndxFind > 0 Then
            strCloseSet = strCloseSet & Mid(strToFind, nLoop, 1)
        End If
        ''Close Set
        
    Next nLoop
    
    strMsg = strOpenSet & vbNewLine & strCloseSet
    Set wsFunc = Nothing

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

