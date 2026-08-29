defmodule Ch1Test do
  use ExUnit.Case, async: true

  describe "dyck_words/1" do
    test "returns all valid Dyck words" do
      test_cases = [
        {0, [""]},
        {1, ["UD"]},
        {2, ["UDUD", "UUDD"]},
        {3,
         [
           "UDUDUD",
           "UDUUDD",
           "UUDDUD",
           "UUDUDD",
           "UUUDDD"
         ]},
        {4,
         [
           "UDUDUDUD",
           "UDUDUUDD",
           "UDUUDDUD",
           "UDUUDUDD",
           "UDUUUDDD",
           "UUDDUDUD",
           "UUDDUUDD",
           "UUDUDDUD",
           "UUDUDUDD",
           "UUDUUDDD",
           "UUUDDDUD",
           "UUUDDUDD",
           "UUUDUDDD",
           "UUUUDDDD"
         ]}
      ]

      for {n, expected} <- test_cases do
        actual = Ch1.dyck_words(n)

        assert actual == expected,
               "For N = #{n}, expected #{inspect(expected)}, got #{inspect(actual)}"
      end
    end
  end
end
