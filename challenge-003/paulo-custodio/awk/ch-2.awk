#!/usr/bin/gawk

# Challenge 003
#
# Challenge #2
# Create a script that generates Pascal Triangle. Accept number of rows from
# the command line. The Pascal Triangle should have at least 3 rows. For more
# information about Pascal Triangle, check this wikipedia page.

function alen(a,     i, k) {
    k = 0;
    for(i in a) k++;
    return k;
}

function push(a, v,    n) {
    n = alen(a);
    while (n in a) n++;
    a[n] = v;
}

function spaces(n,    i, output) {
    output = "";
    for (i = 0; i < n; i++)
        output = output " ";
    return output;
}

function join(array, start, end, sep,    result, i) {
    if (sep == "")
       sep = " ";
    else if (sep == SUBSEP) # magic value
       sep = "";
    result = array[start];
    for (i = start + 1; i <= end; i++)
        result = result sep array[i];
    return result;
}

function draw_pascal(rows,    row, r, i, nrow) {
    row[0] = 1;
    print spaces(rows-1) join(row, 0, alen(row)-1, " ");
    for (r = 1; r < rows; r++) {
        # compute next row
        for (i in nrow) delete nrow[i];
        nrow[0] = 1;
        for (i = 0; i < alen(row)-1; i++)
            push(nrow, row[i]+row[i+1]);
        push(nrow, 1);

        # swap row
        for (i in nrow)
            row[i] = nrow[i];

        # print
        print spaces(rows-r-1) join(row, 0, alen(row)-1, " ");
    }
}

BEGIN {
    n = ARGV[1] ? ARGV[1] : 5;
    draw_pascal(n);
    exit(0);
}
