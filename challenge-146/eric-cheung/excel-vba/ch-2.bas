Attribute VB_Name = "ModTask_02"
Option Explicit

Sub FindCuriousFractionTree(ByVal nNumerator As Integer, ByVal nDenominator As Integer, ByRef nParentNumerator As Integer, ByRef nParentDenominator As Integer)

    If nNumerator > nDenominator Then
        nParentNumerator = nNumerator - nDenominator
        nParentDenominator = nDenominator
    ElseIf nNumerator = nDenominator Then
        nParentNumerator = nNumerator
        nParentDenominator = nDenominator
    Else
        nParentNumerator = nNumerator
        nParentDenominator = nDenominator - nNumerator
    End If

End Sub

Sub Task_02()

    ''Credit: https://gdaymath.com/lessons/fractions/5-3-a-curious-fraction-tree/
    
    '' Example 1
    '' Const nNumeratorInput As Integer = 3
    '' Const nDenominatorInput As Integer = 5
    
    '' Example 2
    Const nNumeratorInput As Integer = 4
    Const nDenominatorInput As Integer = 3
    
    Dim strMsg As String
    Dim nNumeratorInputParent As Integer, nDenominatorInputParent As Integer
    Dim nNumeratorInputGrandParent As Integer, nDenominatorInputGrandParent As Integer
    
    FindCuriousFractionTree nNumeratorInput, nDenominatorInput, nNumeratorInputParent, nDenominatorInputParent
    FindCuriousFractionTree nNumeratorInputParent, nDenominatorInputParent, nNumeratorInputGrandParent, nDenominatorInputGrandParent
    
    strMsg = "Parent: " & nNumeratorInputParent & " / " & nDenominatorInputParent
    strMsg = strMsg & vbNewLine
    strMsg = strMsg & "GrandParent: " & nNumeratorInputGrandParent & " / " & nDenominatorInputGrandParent

    MsgBox strMsg, vbOKOnly, strMyTitle
    
End Sub

