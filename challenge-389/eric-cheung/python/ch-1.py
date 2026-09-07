
## arrMelody = ["Bach", ["C", "D", "E", "F#", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]]  ## Example 1
## arrMelody = ["Beethoven", ["C", "D", "F#", "G", "Ab"], [1, 3, 5, 2, 4]]  ## Example 2
## arrMelody = ["Brahms", ["C", "Db", "Eb", "F", "G", "Ab", "Bb", "C", "D"], [9, 3, 7, 1, 8, 5, 2, 6, 4]]  ## Example 3
## arrMelody = ["Bruckner", ["G", "F#", "Bb", "C", "D", "Eb", "F"], [4, 7, 2, 6, 1, 5, 3]]  ## Example 4
arrMelody = ["Berg", ["C#"], [1]]  ## Example 5

strComposer = arrMelody[0]
arrNotes = arrMelody[1]
arrOrder = arrMelody[2]

arrSortOrder, arrSortNotes = zip(*sorted(zip(arrOrder, arrNotes)))

print (f"{strComposer.upper()} => {" ".join(arrSortNotes)}")
