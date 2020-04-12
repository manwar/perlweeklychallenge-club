raku -e 'put “\e[F\e[K” ~ join “ → ”, (prompt(“\n”).trim-trailing, -> \n { n %% 2 ?? n ÷ 2 !! 3 × n + 1 } … 1)'
