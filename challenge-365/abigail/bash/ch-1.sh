#!/opt/homebrew/bin/bash

ord_a=97

while read word count
do    # 
      # First, turn each letter into its digit index
      #
      for ((i = 1; i <= 26; i ++))
      do  printf -v esc "U+%02x" $((i + ord_a - 1))
          printf -v ch ${esc/U+/"\U"}
          word=${word//$ch/$i}
      done

      #
      # Repeatedly calculate the digit sum
      #
      for ((i = 1; i <= count; i ++))
      do  ((digit_sum  = 0))
          while ((word > 0))
          do    ((digit_sum += word % 10))
                ((word      /=        10))
          done
          ((word = digit_sum))
      done
      echo $word
done
