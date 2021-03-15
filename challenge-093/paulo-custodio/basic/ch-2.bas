' Challenge 093
'
' TASK #2 › Sum Path
' Submitted by: Mohammad S Anwar
' You are given binary tree containing numbers 0-9 only.
'
' Write a script to sum all possible paths from root to leaf.
'
' Example 1:
' Input:
'      1
'     /
'    2
'   / \
'  3   4
'
' Output: 13
' as sum two paths (1->2->3) and (1->2->4)
' Example 2:
' Input:
'      1
'     / \
'    2   3
'   /   / \
'  4   5   6
'
' Output: 26
' as sum three paths (1->2->4), (1->3->5) and (1->3->6)

' input lines
Dim Shared lines() as String

' tree node
Type NodeType
    value as Integer
    left as NodeType Ptr
    right as NodeType Ptr
End Type


' read lines from stdin
Sub read_lines()
    Dim i as Integer
    Open Cons for Input as #1
    i = 0
    Do Until Eof(1)
        Redim Preserve lines(i) as String
        Line Input #1, lines(i)
        i = i+1
    Loop
    Close #1
End Sub


' parse lines, produce a tree
Function parse_subtree(row as Integer, col as Integer) as NodeType Ptr
    Dim node as NodeType Ptr

    'parse root
    node = Callocate(1, Sizeof(NodeType))
    If node=0 Then End -1
    node->value = Val(Mid(lines(row), col, 1))

    'parse children
    if row+2 <= UBound(lines) Then
        If col-2 >= 1 And Mid(lines(row+1), col-1, 1) = "/" Then
            node->left = parse_subtree(row+2, col-2)
        End If
        If col+2 <= Len(lines(row+2)) And Mid(lines(row+1), col+1, 1) = "\" Then
            node->right = parse_subtree(row+2, col+2)
        End If
    End If
    parse_subtree = node
End Function

Function parse_tree() as NodeType Ptr
    Dim root as String, col as Integer
    root = Trim(lines(0))       ' remove spaces, leave only root number
    col = InStr(lines(0), root) ' find its column
    parse_tree = parse_subtree(0, col)
End Function

Sub delete_tree(node as NodeType Ptr)
    if node->left  Then delete_tree(node->left)
    if node->right Then delete_tree(node->right)
    Deallocate(node)
End Sub

' count size of paths
Sub subtree_paths(node as NodeType Ptr, ByRef sum as Integer, ByVal partial as Integer)
    partial = partial + node->value
    If node->left  Then subtree_paths(node->left, sum, partial)
    If node->right Then subtree_paths(node->right, sum, partial)
    If node->left=0 And node->right=0 Then sum = sum + partial
End Sub

Function tree_paths(tree as NodeType Ptr) as Integer
    Dim sum as Integer
    sum = 0
    subtree_paths(tree, sum, 0)
    tree_paths = sum
End Function

' main
Dim tree as NodeType Ptr
read_lines
tree = parse_tree
print tree_paths(tree)
delete_tree(tree)
