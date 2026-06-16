#!/opt/homebrew/bin/gawk

BEGIN {
    split ("a b c d e f g h i j", chars, " ")
}

#
# Loop over each line of input
#
{
    for (i = 1; i <= 10; i ++) {
        gsub (chars [i], i - 1)
    }
    split ($0, nums, " ")
    print nums [1] + nums [2] - nums [3] == 0 ? "true" : "false"
}
