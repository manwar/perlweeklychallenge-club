sub MAIN(Int $m, Int $n) {
    say (1..$m).combinations($n).grep: { [<] |$_ };
}
