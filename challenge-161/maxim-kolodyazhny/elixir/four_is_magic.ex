defmodule FourIsMagic do
  def encode(n) when n in 1..9, do: encode(n, [])
  defp encode(4, io), do: [io, "four is magic."] |> to_string |> String.capitalize()

  defp encode(n, io) do
    names = %{
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine"
    }

    name_len = (n_name = names[n]) |> String.length()

    encode(name_len, [io, n_name, " is #{names[name_len]}, "])
  end
end
