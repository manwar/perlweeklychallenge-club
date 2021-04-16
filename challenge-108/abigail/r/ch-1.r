#
# See ../README.md
#

#
# Run as: Rscript ch-1.r
#

x <- 0
cat (sprintf ("%.0f\n",
         as.numeric (
             paste0 ("0x", 
                 substring (
                     sub (" .*$", "",
                          capture.output (.Internal (inspect (x)))), 2)))))
