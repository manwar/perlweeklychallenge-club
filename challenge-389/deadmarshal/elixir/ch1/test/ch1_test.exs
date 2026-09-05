defmodule Ch1Test do
  use ExUnit.Case, async: true

  describe "reorder_notes/1" do
    test_cases = [
      {"Bach", ["C","D","E","F#","G","A","B"], [7,1,6,2,5,3,4],
       "BACH => D F# A B G E C"},
      {"Beethoven", ["C","D","F#","G","Ab"], [1,3,5,2,4],
       "BEETHOVEN => C G D Ab F#"},
      {"Brahms", ["C","Db","Eb","F","G","Ab","Bb","C","D"], [9,3,7,1,8,5,2,6,4],
       "BRAHMS => F Bb Db D Ab C Eb G C"},
      {"Bruckner", ["G","F#","Bb","C","D","Eb","F"], [4,7,2,6,1,5,3],
       "BRUCKNER => D Bb F G Eb C F#"},
      {"Berg", ["C#"], [1],
       "BERG => C#"}
    ]
    
    for {name, notes, perm, expected} <- test_cases do
      test "Example: #{name}" do
        assert Ch1.reorder_notes({unquote(name),
				  unquote(notes),
				  unquote(perm)}) ==
          unquote(expected)
      end
    end
  end
end

