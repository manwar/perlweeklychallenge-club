#!/usr/bin/env elixir

defmodule PWC do
  import Bitwise
  import String

  def valid(octets) when is_list(octets), do:
    Enum.all?(octets, fn o -> to_integer(o) <= 255 end)

  def valid(octets) do
    if contains?(octets, "/") do
      [octets, mask] = split(octets, "/")
      to_integer(mask) <= 32 and octets |> split(".") |> valid
    else
      octets |> split(".") |> valid
    end
  end

  def octets2int(ip_addr) do
    ip_addr |> split(".") |> Enum.map_reduce(3, fn o, i ->
      { to_integer(o) * 2 ** (8*i), i - 1 }
    end) |> elem(0) |> Enum.sum
  end

  def in_range(ip_addr, domain) do
    [prefix, mask] = split(domain, "/")
    ip_int     = octets2int(ip_addr)
    prefix_int = octets2int(prefix)
    mask       = to_integer(mask)
    mask_int   = bxor(2 ** 32 - 1, 2 ** (32-mask) - 1)
    (ip_int &&& mask_int) == prefix_int
  end

  def subnet_sheriff(ip_addr, domain) do
    valid(ip_addr) and
    valid(domain)  and
    in_range(ip_addr, domain)
  end

  def solution(ip_addr, domain) do
    IO.puts("Input: $ip_addr = \"#{ip_addr}\"")
    IO.puts("       $domain  = \"#{domain}\"")
    IO.puts("Output: #{subnet_sheriff(ip_addr, domain)}")
  end
end

IO.puts("Example 1:")
PWC.solution("192.168.1.45", "192.168.1.0/24")

IO.puts("\nExample 2:")
PWC.solution("10.0.0.256", "10.0.0.0/24")

IO.puts("\nExample 3:")
PWC.solution("172.16.8.9", "172.16.8.9/32")

IO.puts("\nExample 4:")
PWC.solution("172.16.4.5", "172.16.0.0/14")

IO.puts("\nExample 5:")
PWC.solution("192.0.2.0", "192.0.2.0/25")
