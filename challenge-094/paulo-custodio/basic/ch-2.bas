' Challenge 094
'
' TASK #2 › Binary Tree to Linked List
' Submitted by: Mohammad S Anwar
' You are given a binary tree.
'
' Write a script to represent the given binary tree as an object and flatten
' it to a linked list object. Finally print the linked list object.
'
' Example:
'   Input:
'
'       1
'      / \
'     2   3
'    / \
'   4   5
'      / \
'     6   7
'
'   Output:
'
'       1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

' input lines
Dim Shared lines() as String

' tree node
Type NodeType
    value as Integer
    left_node as NodeType Ptr
    right_node as NodeType Ptr
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
            node->left_node = parse_subtree(row+2, col-2)
        End If
        If col+2 <= Len(lines(row+2)) And Mid(lines(row+1), col+1, 1) = "\" Then
            node->right_node = parse_subtree(row+2, col+2)
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
    if node->left_node  Then delete_tree(node->left_node)
    if node->right_node Then delete_tree(node->right_node)
    Deallocate(node)
End Sub


' flatten a tree
Sub flatten_tree(root as NodeType Ptr)
    Dim left_node as NodeType Ptr, right_node as NodeType Ptr, node as NodeType Ptr
    If root <> 0 Then
        left_node = root->left_node: flatten_tree(left_node)
        right_node = root->right_node: flatten_tree(right_node)

        root->left_node = 0
        root->right_node = left_node

        node = root
        Do While node->right_node <> 0
            node = node->right_node
        Loop

        node->right_node = right_node
    End If
End Sub

Sub print_tree(root as NodeType Ptr)
    Dim node as NodeType Ptr
    node = root
    Do While node <> 0
        If node <> root Then Print " -> ";
        Print Trim(Str(node->value));
        node = node->right_node
    Loop
    Print
End Sub

' main
Dim tree as NodeType Ptr
read_lines
tree = parse_tree
flatten_tree tree
print_tree tree
delete_tree tree
