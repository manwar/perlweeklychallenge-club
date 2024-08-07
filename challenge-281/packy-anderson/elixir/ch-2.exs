#!/usr/bin/env elixir

defmodule PWC do
  defp letterAdd(letter, add) do
    <<val::utf8>> = letter
    List.to_string([val + add])
  end

  def onBoard(c,r) do
    "a" <= c and c <= "h" and 1 <= r and r <= 8
  end

  defp knightMoveList(), do: [
    {-2, -1}, {-2, +1}, {-1, -2}, {-1, +2},
    {+2, -1}, {+2, +1}, {+1, -2}, {+1, +2},
  ]

  def knightMoves([], _, _, endpoints), do: endpoints

  def knightMoves([next | rest], letter, num, endpoints) do
    {col, row} = next
    newcol = letterAdd(letter, col)
    newrow = num + row
    endpoints = if onBoard(newcol,newrow) do
      # add to list being returned
      endpoints ++ [ newcol <> to_string(newrow) ]
    else
      endpoints
    end
    knightMoves(rest, letter, num, endpoints)
  end

  def knightMoves(coordinates) do
    letter = String.first(coordinates)
    {num, _} = Integer.parse(String.last(coordinates))
    knightMoves(knightMoveList(), letter, num, [])
  end

  def processEndpoints(
    next, params = %{
      moves_to: moves_to,
      path_to:  path_to,
      startPos: startPos,
      endPos:   endPos,
      queue:    queue
    }
  ) do
    # update the move count map
    moves_to = Map.put(moves_to, next, moves_to[startPos] + 1)

    # update the path to current space map
    path_to = Map.put(path_to, next,
      "#{path_to[startPos]} -> #{next}"
    )

    if next == endPos do
      # we found the shortest path, update the return
      # values which will stop the loop
      %{ moves: moves_to[next], path: path_to[next] }
    else
      # update params for next iteration
      params |> Map.put(:moves_to, moves_to)
             |> Map.put(:path_to,  path_to)
             |> Map.put(:queue,    queue ++ [ next ])
    end
  end

  def processEndpoints(_, params = %{moves: moves})
    when not is_nil(moves), do: params

  # we've exhausted the queue
  # (only possible when the chessboard is an odd size)
  def processQueue([], _), do: %{
    moves: -1, path: "no path found"
  }

  def processQueue(_, params = %{moves: moves})
    when not is_nil(moves), do: params

  def processQueue([startPos | queue], params = %{
    path_to: path_to
  }) do
    # put the current starting position and the current queue
    # into the params
    params = params |> Map.put(:queue,    queue)
                    |> Map.put(:startPos, startPos)

    # figure out the valid moves that we haven't been to yet
    endpoints = knightMoves(startPos)
    |> Enum.filter(fn m -> !Map.has_key?(path_to, m) end)

    # call processEndpoints/2 for each of the endpoints
    params = Enum.reduce(endpoints, params, &processEndpoints/2)

    # recursively call to process the rest of the queue
    processQueue(params[:queue], params)
  end

  # trivial case: we're already at the end point
  def leastMoves(startPos, endPos) when startPos == endPos, do:
    { 0, endPos }

  def leastMoves(startPos, endPos) do
    params = processQueue([ startPos ], %{
      endPos:   endPos,
      moves_to: %{ startPos => 0 },
      path_to:  %{ startPos => startPos },
      moves:    nil,
      path:     nil
    })
    { params[:moves], params[:path] }
  end

  def solution(startPos, endPos) do
    IO.puts("Input: $start = '#{startPos}', $end = '#{endPos}'")
    {count, moves} = leastMoves(startPos, endPos)
    IO.puts("Output: #{to_string(count)}\n\n#{moves}" )
  end
end

IO.puts("Example 1:")
PWC.solution("g2", "a8")

IO.puts("\nExample 2:")
PWC.solution("g2", "h2")

IO.puts("\nExample 3:")
PWC.solution("a1", "h8")
