# run for example as:
# echo '5 2 9 1 7 6
# 4 2 3 1 5 0' | awk -f ./max-index.awk

function find_max() {
    max_i = 0
    max_n = $1
    for (i = 2; i < NF; i++) {
        if ($i > max_n) {
            max_i = i
            max_n = $i
        }
    }
    printf("Max index for %s: %d => %d\n", $0, max_i - 1, max_n)
}
{
    find_max()
}
