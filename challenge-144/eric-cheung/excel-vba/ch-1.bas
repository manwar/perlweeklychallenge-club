Attribute VB_Name = "ModTask_01"
Option Explicit

Public Const strMyTitle As String = "Eric Cheung"

Function IsPrime(nInput As Integer) As Boolean

    Dim nLoop As Integer
    
    If nInput = 1 Then
        IsPrime = False
        Exit Function
    End If
    
    For nLoop = 2 To Int(Sqr(nInput))
        If nInput Mod nLoop = 0 Then
            IsPrime = False
            Exit Function
        End If
    Next nLoop
    
    IsPrime = True
    
End Function

Function IsSemiPrime(nInput As Integer) As Boolean

    Dim nPrimeLoop As Integer
    Dim bByPassLoop As Boolean
    
    For nPrimeLoop = 2 To nInput - 2

        bByPassLoop = False

        If nInput Mod nPrimeLoop > 0 Then
            bByPassLoop = True
        End If
        
        If Not bByPassLoop And Not IsPrime(nPrimeLoop) Then
            bByPassLoop = True
        End If
        
        If Not bByPassLoop And Not IsPrime(nInput / nPrimeLoop) Then
            bByPassLoop = True
        End If
        
        If Not bByPassLoop Then
            IsSemiPrime = True
            Exit Function
        End If

    Next nPrimeLoop
    
    IsSemiPrime = False

End Function

Sub Task_01()

    Dim strMsg As String
    Dim nMainLoop As Integer
    
    For nMainLoop = 2 To 100
        If IsSemiPrime(nMainLoop) Then
            If strMsg <> "" Then
                strMsg = strMsg & ", "
            End If
            strMsg = strMsg & nMainLoop
        End If
    Next nMainLoop

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub


