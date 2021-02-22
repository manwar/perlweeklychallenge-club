' Challenge 094
'
' TASK #1 › Group Anagrams
' Submitted by: Mohammad S Anwar
' You are given an array of strings @S.
'
' Write a script to group Anagrams together in any random order.
'
' An Anagram is a word or phrase formed by rearranging the letters of a
' different word or phrase, typically using all the original letters exactly
' once.
'
' Example 1:
'     Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
'     Output: [ ("bat", "tab"),
'               ("saw", "was"),
'               ("top", "pot", "opt") ]
' Example 2:
'     Input: ("x")
'     Output: [ ("x") ]

' List of strings
Type ListNodeType
    value as String
    nxt as ListNodeType Ptr
End Type

Type ListType
    head as ListNodeType Ptr
    tail as ListNodeType Ptr
End Type


' Map of keys to lists of strings
Type MapNodeType
    key as String
    values as ListType
    nxt as MapNodeType Ptr
End Type

Type MapType
    head as MapNodeType Ptr
    tail as MapNodeType Ptr
End Type


Sub list_push(Byref list as ListType, value as String)
    Dim node as ListNodeType Ptr
    node = Callocate(1, Sizeof(ListNodeType))
    node->value = value
    if list.head = 0 Then
        list.head = node
        list.tail = node
    Else
        list.tail->nxt = node
        list.tail = node
    End If
End Sub

Sub list_delete(Byref list as ListType)
    Dim node as ListNodeType Ptr, nxt as ListNodeType Ptr
    node = list.head
    Do While node <> 0
        nxt = node->nxt
        Deallocate(node)
        node = nxt
    Loop
End Sub

Sub list_print(Byref list as ListType)
    Dim node as ListNodeType Ptr
    Print "(";
    node = list.head
    Do While node <> 0
        If node <> list.head Then Print ", ";
        Print """"; node->value; """";
        node = node->nxt
    Loop
    Print ")";
End Sub


' add/find a key
Function map_add_key(Byref map as MapType, key as String) as ListType Ptr
    Dim node as MapNodeType Ptr
    If map.head = 0 Then                ' map empty
        node = Callocate(1, Sizeof(MapNodeType))
        map.head = node
        map.tail = node
        node->key = key
        map_add_key = @node->values
    Else
        node = map.head
        Do While node <> 0
            If node->key = key Then     ' found key
                map_add_key = @node->values
                Exit Function
            End If
            node = node->nxt
        Loop

        ' not found
        node = Callocate(1, Sizeof(MapNodeType))
        node->key = key
        map.tail->nxt = node
        map.tail = node
        map_add_key = @node->values
    End If
End Function

' add key/value
Sub map_add_key_value(Byref map as MapType, key as String, value as String)
    Dim list as ListType Ptr
    list = map_add_key(map, key)
    list_push(*list, value)
End Sub

Sub map_print(Byref map as MapType)
    Dim node as MapNodeType Ptr
    print "[ ";
    node = map.head
    Do While node <> 0
        If node <> map.head Then Print ",":Print "  ";
        list_print(node->values)
        node = node->nxt
    Loop
    Print " ]"
End Sub

Sub map_delete(Byref map as MapType)
    Dim node as MapNodeType Ptr, nxt as MapNodeType Ptr
    node = map.head
    Do While node <> 0
        nxt = node->nxt
        list_delete(node->values)
        Deallocate(node)
        node = nxt
    Loop
End Sub


' sort a string - selection sort
Function sort_string(Byval s as String) as String
    dim i as Integer, j as Integer, min_i as Integer
    dim c as String

    for i=0 to len(s)-1
        min_i=i
        for j=i+1 to len(s)
            if Asc(Mid(s,j,1)) < Asc(Mid(s,min_i,1)) Then
                min_i=j
            End If
        Next j

        ' swap
        c=Mid(s,i,1)
        Mid(s,i,1)=Mid(s,min_i,1)
        Mid(s,min_i,1)=c
    next i
    sort_string = s
End Function


' read strings from command line, build map
Sub read_strings(Byref map as MapType)
    Dim key as String, value as String
    Dim i as Integer
    i = 1
    Do While Command(i) <> ""
        value = Command(i)
        key = sort_string(value)
        map_add_key_value(map, key, value)
        i = i+1
    Loop
End Sub

' main
Dim map as MapType
read_strings(map)
map_print(map)
map_delete(map)
