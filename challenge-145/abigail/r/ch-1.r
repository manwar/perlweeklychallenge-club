#
# See ../README.md
#

#
# Run as: Rscript ch-1.r < input-file
#

stdin <- file ('stdin', 'r')

cat (as.numeric (strsplit (readLines (stdin, n = 1), " ") [[1]]) %*%
     as.numeric (strsplit (readLines (stdin, n = 1), " ") [[1]]), "\n")
