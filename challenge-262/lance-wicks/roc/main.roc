app "mpn"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br" }
    imports [pf.Stdout]
    provides [main] to pf

main =
    dbg positives [-3, 1, 2, -1, 3, -2, 4]
    dbg negatives [-3, 1, 2, -1, 3, -2, 4]
    dbg maxNegOrPos [-3, 1, 2, -1, 3, -2, 4]
    dbg maxNegOrPos [-1, -2, -3, 1]
    Stdout.line "run this with 'roc dev'"


maxNegOrPos = \ints ->
    if positives ints > negatives ints then
       positives ints
    else if negatives ints > positives ints then
       negatives ints
    else
       0

positives = \ints ->
    List.countIf ints Num.isPositive

negatives = \ints ->
    List.countIf ints Num.isNegative 


# Tests
expect positives [-3, 1, 2, -1, 3, -2, 4] == 4
expect negatives [-3, 1, 2, -1, 3, -2, 4] == 3
expect maxNegOrPos [-3, 1, 2, -1, 3, -2, 4] == 4

expect positives [-1, -2, -3, 1] == 1
expect negatives [-1, -2, -3, 1] == 3
expect maxNegOrPos [-1, -2, -3, 1] == 3

expect positives [1,2] == 2
expect negatives [1,2] == 0
expect maxNegOrPos [1,2] == 2