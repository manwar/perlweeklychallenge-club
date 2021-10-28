' Challenge 003
'
' TASK #1 > Ugly Numbers
' Submitted by: Mohammad S Anwar
' You are given an integer $n >= 1.
'
' Write a script to find the $nth element of Ugly Numbers.
'
' Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
' the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
'
' Example
' Input: $n = 7
' Output: 8
'
' Input: $n = 10
' Output: 12

' deque of integers
type ElemType
    nValue as integer
    pNext as ElemType ptr
end type

type QType
    pFront as ElemType ptr
    pBack as ElemType ptr
end type

function QEmpty(byref q as QType) as boolean
    if q.pFront = 0 then
        QEmpty = true
    else
        QEmpty = false
    end if
end function

function QFront(byref q as QType) as integer
    QFront = q.pFront->nValue
end function

function QBack(byref q as QType) as integer
    QBack = q.pBack->nValue
end function

sub QPushBack(byref q as QType, nValue as integer)
    dim pElem as ElemType ptr

    pElem = callocate(1, sizeof(ElemType))
    pElem->nValue = nValue

    if q.pFront = 0 then
        q.pFront = pElem
        q.pBack = pElem
    else
        q.pBack->pNext = pElem
        q.pBack = pElem
    end if
end sub

sub QPopBack(byref q as QType)
    dim pElem as ElemType ptr

    if q.pFront = 0 then            ' empty
    elseif q.pFront = q.pBack then  ' only one element
        deallocate q.pFront
        q.pFront = 0
        q.pBack = 0
    else                            ' more than one element
        pElem = q.pFront
        do while pElem->pNext <> q.pBack
            pElem = pElem->pNext
        loop
        deallocate q.pBack
        q.pBack = pElem
        pElem->pNext = 0
    end if
end sub

sub QPushFront(byref q as QType, nValue as integer)
    dim pElem as ElemType ptr

    pElem = callocate(1, sizeof(ElemType))
    pElem->nValue = nValue

    if q.pFront = 0 then
        q.pFront = pElem
        q.pBack = pElem
    else
        pElem->pNext = q.pFront
        q.pFront = pElem
    end if
end sub

sub QPopFront(byref q as QType)
    dim pElem as ElemType ptr

    if q.pFront = 0 then            ' empty
    elseif q.pFront = q.pBack then  ' only one element
        deallocate q.pFront
        q.pFront = 0
        q.pBack = 0
    else                            ' more than one element
        pElem = q.pFront
        q.pFront = pElem->pNext
        deallocate pElem
    end if
end sub


function min(a as integer, b as integer) as integer
    if a < b then
        min = a
    else
        min = b
    end if
end function

function min3(a as integer, b as integer, c as integer) as integer
    min3 = min(a, min(b, c))
end function


' Hamming generator
dim shared q2 as QType
dim shared q3 as QType
dim shared q5 as QType

function next_hamming() as integer
    dim n as integer

    ' init queues at start
    if QEmpty(q2) then
        QPushBack q2, 1
        QPushBack q3, 1
        QPushBack q5, 1
    end if

    ' get the smallest of the queue heads
    n = min3(QFront(q2), QFront(q3), QFront(q5))

    ' shift used multiples
    if n = QFront(q2) then QPopFront q2
    if n = QFront(q3) then QPopFront q3
    if n = QFront(q5) then QPopFront q5

    ' push next multiples
    QPushBack q2, 2*n
    QPushBack q3, 3*n
    QPushBack q5, 5*n

    next_hamming = n
end function

' main
dim i as integer
for i=1 to val(command(1))
    print next_hamming()
next i
