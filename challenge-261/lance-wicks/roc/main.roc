app "hello"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br" }
    imports [pf.Stdout]
    provides [main] to pf

main =
    dbg elementSum [1,2,3,45]
    dbg digitSum [1,2,3,45]
    dbg absDiff [1,2,3,45]
    #Stdout.line (Num.toStr (absDiff ints))


    Stdout.line "run this with 'roc dev'"


absDiff = \ints ->
    Num.absDiff (elementSum ints) (digitSum ints)


elementSum = \ints ->
    ints 
        |> List.walk 0 Num.add

digitSum = \list ->
    List.map list (\n ->
        if n < 11 then
            n + 0
        else
            digits n
            |> List.sum
     )
     |> List.sum


digits = \num ->
    helper = \list, n ->
        if n == 0 then
            list
        else
            list
            |> List.append (Num.rem n 10)
            |> helper (n // 10)
    helper [] num
    |> List.reverse


# TESTS        
# Example 1
expect elementSum [1,2,3,45] == 51
expect digitSum [1,2,3,45] == 15
expect absDiff [1,2,3,45] == 36

# Example 2
expect elementSum [1,12,3] == 16
expect digitSum [1,12,3] == 7
expect absDiff [1,12,3] == 9

# Example 3
expect elementSum [1,2,3,4] == 10
expect digitSum [1,2,3,4] == 10
expect absDiff [1,2,3,4] == 0

# Example 4
expect absDiff [236, 416, 336, 350] == 1296
