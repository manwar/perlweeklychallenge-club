# Run for example as:
# echo ' 5/2
# 2/5
# 3/5' | awk -f fraction-tree.awk
function parent()
{
    if (a < b) {
        b = b - a
    } else {
        a = a - b
    }
}
BEGIN {
    a = 0
    b = 0
    FS = "/"
}
{
    a = $1
    b = $2
    printf "Node = %d/%d: ", a, b
    parent()
    printf "Parent = %d/%d; ", a, b
    parent()
    printf "Grand-parent = %d/%d\n", a, b
}
