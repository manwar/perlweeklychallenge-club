#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

gcd <- function (u, v) {
    u_odd <- u %% 2 != 0
    v_odd <- v %% 2 != 0

         if (u == v | v == 0) {u}
    else if (         u == 0) {v}
    else if (!u_odd & !v_odd) {
                   bitwShiftL (gcd (bitwShiftR (u, 1), bitwShiftR (v, 1)), 1)}
    else if (!u_odd &  v_odd) {gcd (bitwShiftR (u, 1), v)}
    else if ( u_odd & !v_odd) {gcd (u, bitwShiftR (v, 1))}
    else if ( u     >  v)     {gcd (u - v, v)}
    else                      {gcd (v - u, u)}
}

is_power_of_n <- function (number, n) {
         if (number <  1)      {FALSE}
    else if (number == 1)      {TRUE}
    else if (number %% n != 0) {FALSE}
    else                       {is_power_of_n (number / n, n)}
}

is_power_of_2 <- function (number) {
    is_power_of_n (number, 2)
}

stdin <- file ('stdin', 'r')
repeat {
    line <- readLines (stdin, n = 1)
    if (length (line) == 0) {
        break
    }
    parts <- strsplit (line, " ")

    m <- as.numeric (parts [[1]] [[1]])
    n <- as.numeric (parts [[1]] [[2]])

    if (n %% 2 == 1 | m %% 2 == 1) {
        cat ("0\n")
    }
    else {
        r <- gcd (n, m)

        if (r > 1 & is_power_of_2 (r)) {
            cat ("1\n")
        }
        else {
            cat ("0\n")
        }
    }
}
