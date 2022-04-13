unit sub MAIN(
    *@n, #= array of integers
);

for 0 .. @n.end -> $i {
    if @n[0 .. $i - 1].sum == @n[$i + 1 .. *].sum {
        put $i;
        exit;
    }
}
put -1;
