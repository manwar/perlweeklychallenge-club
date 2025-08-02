app "Product Sign (267)"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br" }
    imports [pf.Stdout, pf.Arg, pf.Task]
    provides [main] to pf

main =
    args <- Arg.list |> Task.await

    dbg args

    ints = List.dropFirst args 1
    dbg ints

    nums = List.mapTry ints Str.toI8
    dbg nums

    theNums = Result.withDefault nums []
    dbg theNums

    result = productSign theNums
    dbg result

    Stdout.line "run this with 'roc dev -- 1 2 3 4'"

productSign = \ints ->
    positive = List.product ints
    if positive > 0 then
        1
    else if positive == 0 then
        0
    else
        -1

expect
    input = [-1, -2, -3, -4, 3, 2, 1]
    out = productSign input
    out == 1

expect
    input = [1, 2, 0, -2, -1]
    out = productSign input
    out == 0

expect
    input = [-1, -1, 1, -1, 2]
    out = productSign input
    out == -1
