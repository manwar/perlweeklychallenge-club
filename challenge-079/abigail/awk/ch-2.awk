#
# Challenge:
#
#    You are given an array of positive numbers @N.
#    Write a script to represent it as Histogram Chart and find out
#    how much water it can trap.
#

{
    #
    # First, find the maximum value.
    #
    max = 0;
    for (i = 1; i <= NF; i ++) {
        if ($i > max) {
            max = $i;
        }
    }

    #
    # Given the value, we know how wide every column must be.
    #
    format = "%" length (max) "s";
    show   = sprintf (" " format, "#");
    noshow = sprintf (" " format, " ");

    #
    # Print the histogram
    #
    for (vol = max; vol; vol --) {
        printf format, vol;
        for (i = 1; i <= NF; i ++) {
            if ($i >= vol) {printf   show;}
            else           {printf noshow;}
        }
        printf "\n";
    }

    #
    # Print the line with the bars.
    #
    bar = "";
    for (i = 0; i < length (max); i ++) {
        bar = bar "_";
    }
    printf bar;
    for (i = 1; i <= NF; i ++) {
        printf " " bar;
    }
    printf "\n";

    #
    # Print the line with the totals
    #
    printf format, " ";
    for (i = 1; i <= NF; i ++) {
        printf " " format, $i;
    }
    printf "\n";
}
