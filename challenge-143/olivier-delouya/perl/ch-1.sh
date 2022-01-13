calculator='print(eval($e));'

perl -se $calculator -- -e="10 + 20 - 5"

perl -se $calculator -- -e="(10 + 20 - 5) * 2"
