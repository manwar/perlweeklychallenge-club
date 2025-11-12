#!/usr/bin/env elixir

defmodule PWC do
  def format_date(_, _, _, year) when year < 1900,
    do: "Year must be between 1900-2100"

  def format_date(_, _, _, year) when year > 2100,
    do: "Year must be between 1900-2100"

  def format_date(_, month, mnum, _) when is_nil(mnum),
    do: "Unknown month '#{month}'"

  def format_date(dnum, _, mnum, year) do
    with {:ok, date} <- Date.new(year, mnum, dnum) do
      "\"#{date |> Date.to_iso8601}\""
    else
      {:error, :invalid_date} -> "Invalid date"
    end
  end

  def format_date(str) do
    [day, month, year] = String.split(str)

    m = Regex.named_captures(~r'(?<dnum>\d+)(?<dord>\D+)', day)
    dnum = m["dnum"] |> String.to_integer # make sure it's an int

    if not (
      ((dnum == 1 or dnum == 21 or dnum == 31) and
       m["dord"] == "st")
      or
      ((dnum == 2 or dnum == 22) and m["dord"] == "nd")
      or
      ((dnum == 3 or dnum == 23) and m["dord"] == "rd")
      or
      m["dord"] == "th"
    ) do
      "#{day} has the incorrect ordinal"
    else
      year = year |> String.to_integer # make sure it's an int
      mnum = Map.get(%{
        "Jan" => 1, "Feb" => 2,  "Mar" => 3,  "Apr" => 4,
        "May" => 5, "Jun" => 6,  "Jul" => 7,  "Aug" => 8,
        "Sep" => 9, "Oct" => 10, "Nov" => 11, "Dec" => 12
      }, month)
      format_date(dnum, month, mnum, year)
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> format_date(str))
  end
end

IO.puts("Example 1:")
PWC.solution("1st Jan 2025")

IO.puts("\nExample 2:")
PWC.solution("22nd Feb 2025")

IO.puts("\nExample 3:")
PWC.solution("15th Apr 2025")

IO.puts("\nExample 4:")
PWC.solution("23rd Oct 2025")

IO.puts("\nExample 5:")
PWC.solution("31st Dec 2025")

IO.puts("\nExample Year Too Big:")
PWC.solution("31st Dec 2525")

IO.puts("\nExample Year Too Small:")
PWC.solution("31st Dec 1825")

IO.puts("\nExample Bad Ordinal:")
PWC.solution("31nd Dec 2025")

IO.puts("\nExample Bad Month:")
PWC.solution("30th Avril 2025")

IO.puts("\nExample Bad Date:")
PWC.solution("31st Feb 2025")
