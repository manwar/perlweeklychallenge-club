#!/usr/bin/env elixir
locales = ["fr", "en", "de", "ja"]

Mix.install([ {:ex_cldr_numbers, "~> 2.33"} ])

# the Cldr documentation calls this a "Backend Module"
defmodule PWC.Cldr do
  use Cldr,
    default_locale: "en",
    locales: locales,
    add_fallback_locales: false,
    providers: [Cldr.Number],
    data_dir: "./priv/cldr"
end

defmodule PWC do
  def spellbound(nums) do
    words_to_num = Enum.reduce(nums, %{}, fn num, words_to_num ->
      {_, words} = PWC.Cldr.Number.to_string(
        num, format: :spellout
      )
      Map.put(words_to_num, words, num)
    end)
    wordlist = words_to_num |> Map.keys |> Enum.sort
    {
      Enum.join(wordlist, ", "),
      Enum.reduce(wordlist, [], fn word, result ->
        result ++ [ Map.get(words_to_num, word) ]
      end)
    }
  end

  def solution(nums) do
    IO.puts("Input: (" <> Enum.join(nums, ", ") <> ")")
    {words, sorted} = spellbound(nums)
    IO.puts("Output: (" <> Enum.join(sorted, ", ") <> ")")
    IO.puts("\n#{PWC.Cldr.get_locale()}: " <> words)
  end
end

# process the command line for the language
options = [ language: :string, help: :boolean ]
case OptionParser.parse(System.argv(), strict: options) do
  {parsed, _args, []} ->
    cond do
      parsed[:help] ->
        IO.puts("usage: ch-2.exs --language <language>")
      parsed[:language] ->
        ok = locales |> Enum.find_value(
          fn l -> if l == parsed[:language], do: true, else: false
        end)
        if ok do
          PWC.Cldr.put_locale(parsed[:language])
        else
          IO.puts("Unknown locale: #{parsed[:language]}")
          IO.puts("Locales: #{inspect(locales)}")
          System.halt(1)
        end
      true -> :noop
    end
  {_parsed, _args, invalid} ->
    IO.puts("Invalid arguments: #{inspect(invalid)}")
    System.halt(1)
end

IO.puts("Example 1:")
PWC.solution([6, 7, 8, 9, 10])

IO.puts("\nExample 2:")
PWC.solution([-3, 0, 1000, 99])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 4:")
PWC.solution([0, -1, -2, -3, -4])

IO.puts("\nExample 5:")
PWC.solution([100, 101, 102])
