#!/usr/bin/env elixir

defmodule PWC do
  defp countHas(has, data) when has != 0, do: data

  defp countHas(_, data) do
    # we need to add a character of this type
    data = Map.put(data, :changes, data[:changes]+1)

    if data[:replacements] > 0 do
      # if we have characters that need to be REPLACED,
      # we don't need to add to the string length to
      # make the change
      Map.put(data, :replacements, data[:replacements]-1)
    else
      # we need to add characters to make the change
      Map.put(data, :length, data[:length]+1)
    end
  end

  defp putIf(map, condition, _, _) when not condition,
  do: map

  defp putIf(map, _, key, value) do
    Map.put(map, key, value)
  end

  def strongPassword(str) do
    data = %{
      hasUpper: 0,
      hasLower: 0,
      hasDigit: 0,
      runs: []
    }

    chars = String.graphemes(str)

    {_, data} =
      Enum.map_reduce(chars, data, fn char, data ->
        # identify runs of characters
        runs = data[:runs]
        runs = cond do
          # we have no previous run of characters, or the last
          # character of the last run doesn't match this character
          length(runs) == 0
          or
          List.last(runs) |> String.last != char ->
            runs ++ [ char ]

          # append the latest character to the run
          true ->
            List.replace_at(runs, -1, List.last(runs) <> char)
        end

        # put the runs back in the data map
        data = Map.put(data, :runs, runs)

        # count the character classes we're interested in
        # and return the data map to Enum.map_reduce/3
        {
          char,
          cond do
            Regex.match?(~r/\p{Lu}/u, char) ->
              Map.put(data, :hasUpper, data[:hasUpper]+1)
            Regex.match?(~r/\p{Ll}/u, char) ->
              Map.put(data, :hasLower, data[:hasLower]+1)
            Regex.match?(~r/\p{N}/u, char) ->
              Map.put(data, :hasDigit, data[:hasDigit]+1)
          end
        }
      end)

    # count how many characters need to be REPLACED
    {_, replacements} =
      Enum.map_reduce(data[:runs], 0, fn run, replacements ->
        {
          run,
          if String.length(run) >= 3 do
            replacements + trunc(String.length(run) / 3)
          else
            replacements
          end
        }
      end)

    # store some more stuff in our data map
    data = data
    |> Map.put(:changes, 0)
    |> Map.put(:length, String.length(str))
    |> Map.put(:replacements, replacements)

    hasList = [
      data[:hasUpper], data[:hasLower], data[:hasDigit]
    ]

    # figure out how many changes are needed
    {_, data} =
      Enum.map_reduce(hasList, data, fn has, data ->
        { has, countHas(has, data) }
      end)

    data
    |> putIf(data[:length] < 6, :changes,
             data[:changes] + 6 - data[:length] )
    |> putIf(data[:replacements] > 0, :changes,
             data[:changes] + data[:replacements])
    |> Map.get(:changes)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{strongPassword(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("a")

IO.puts("\nExample 2:")
PWC.solution("aB2")

IO.puts("\nExample 3:")
PWC.solution("PaaSW0rd")

IO.puts("\nExample 4:")
PWC.solution("Paaasw0rd")

IO.puts("\nExample 5:")
PWC.solution("aaaaa")

IO.puts("\nExample 6:")
PWC.solution("aaaaaabbbb")

IO.puts("\nExample 7:")
PWC.solution("voilÀ३")
