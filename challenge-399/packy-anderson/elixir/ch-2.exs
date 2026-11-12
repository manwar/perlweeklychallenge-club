#!/usr/bin/env elixir

defmodule PWC do
  defp reduce_fn(entry, {files, level, explain}) do
    # count the tabs
    deep = String.count(entry, "\t")

    {entry, files, explain} =
      if deep > 0 do
        # eliminate the tabs
        entry = String.replace(entry, "\t", "")

        dir = Map.get(level, deep - 1)
        entry = Enum.join([dir, entry], "/")

        {files, explain} =
          if length(files) > 0 and dir == Enum.at(files, -1) do
            {
              List.delete_at(files, -1),
              "\"#{dir}\" is a directory " <>
                "(it has children beneath it).\n"
            }
          else
            {files, explain}
          end

        {entry, files, explain}
      else
        {entry, files, explain}
      end

    files =
      if Regex.match?(~r"[^/]+\.[^/]+$", entry),
        do: files ++ [entry],
        else: files

    {
      files,
      Map.put(level, deep, entry),
      explain
    }
  end

  def longest_absolute_path(fs) do
    {files, _level, explain} =
      fs
      |> String.split("\n")
      |> Enum.reduce({[], %{}, ""}, &reduce_fn/2)

    if length(files) == 0 do
      {
        0,
        "There are no files in the system (a file must " <>
          "contain a . character\nseparating a name and " <>
          "extension).\nSince there are no files, " <>
          "the answer is 0."
      }
    else
      explain = explain <> "Found File Paths:\n"

      filelist =
        files
        |> Enum.map(
          &"    \"#{&1}\" (length #{String.length(&1)})"
        )
        |> Enum.join("\n")

      max =
        files
        |> Enum.map(&String.length(&1))
        |> Enum.max()

      {max, explain <> filelist}
    end
  end

  def solution(fs) do
    display =
      fs
      |> String.replace("\n", "\\n")
      |> String.replace("\t", "\\t")

    IO.puts("Input: $fs = \"#{display}\"")
    {len, explain} = longest_absolute_path(fs)
    IO.puts("Output: #{len}\n\n#{explain}")
  end
end

IO.puts("Example 1")
PWC.solution("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2")

IO.puts("\nExample 2")
PWC.solution("file1.txt\nfile2.ext\na.png")

IO.puts("\nExample 3")

PWC.solution(
  "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
)

IO.puts("\nExample 4")
PWC.solution("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt")

IO.puts("\nExample 5")

PWC.solution(
  "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"
)
