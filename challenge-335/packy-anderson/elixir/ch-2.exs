#!/usr/bin/env elixir

defmodule PWC do
  def empty_game_board() do
    [
      [ "_", "_", "_" ],
      [ "_", "_", "_" ],
      [ "_", "_", "_" ]
    ]
  end

  def display_game_board([], output), do: output
  def display_game_board([r | board], output) do
    display_game_board(board,
      output <> "\n[ " <> Enum.join(r, " ") <> " ]"
    )
  end

  def display_game_board(board) do
    display_game_board(board, "Game Board:")
  end

  def make_move(letter, move, board) do
    y = List.first(move)
    x = List.last(move)
    List.replace_at(
      board, y,
      List.replace_at(
        Enum.at(board, y), x, letter
      )
    )
  end

  def make_moves([], _, board), do: board
  def make_moves([move | moves], letter, board) do
    board = make_move(letter, move, board)
    letter = if letter == "A", do: "B", else: "A"
    make_moves(moves, letter, board)
  end

  def same(x, y, z), do: x != "_" && x == y && y == z

  def check_rows([]), do: {:error, :not_found}
  def check_rows([row | board]) do
    if same(Enum.at(row, 0),
            Enum.at(row, 1),
            Enum.at(row, 2)) do
      {:ok, Enum.at(row, 0)} # winner
    else
      check_rows(board) # check next row
    end
  end

  def at_2d(board, y, x), do: Enum.at(Enum.at(board, y), x)

  def check_columns(_, x) when x > 2, do: {:error, :not_found}
  def check_columns(board, x) do
    if same(at_2d(board, 0, x),
            at_2d(board, 1, x),
            at_2d(board, 2, x)) do
      {:ok, at_2d(board, 0, x)} # winner
    else
      check_columns(board, x+1) # check next column
    end
  end

  def check_diagonals(board) do
    cond do
      same(at_2d(board, 0, 0),
           at_2d(board, 1, 1),
           at_2d(board, 2, 2)) ->
        {:ok, at_2d(board, 1, 1)} # winner
      same(at_2d(board, 2, 0),
           at_2d(board, 1, 1),
           at_2d(board, 0, 2)) ->
        {:ok, at_2d(board, 1, 1)} # winner
      true ->
        {:error, :not_found}
    end
  end

  def check_for_winner(board, moves) do
    with {:error, :not_found} <- check_rows(board),
         {:error, :not_found} <- check_columns(board, 0),
         {:error, :not_found} <- check_diagonals(board) do
      if length(moves) < 9, do: "Pending", else: "Draw"
    else
      {:ok, winner} -> winner
    end
  end

  def find_winner(moves) do
    board = make_moves(moves, "A", empty_game_board())
    { check_for_winner(board, moves), display_game_board(board) }
  end

  def move_list(moves) do
    moves
    |> Enum.map(fn m -> "[#{List.first(m)},#{List.last(m)}]" end)
    |> Enum.join(", ")
  end

  def solution(moves) do
    IO.puts("Input: @moves = (#{move_list(moves)})")
    {winner, board} = find_winner(moves)
    IO.puts("Output: #{winner}\n\n#{board}")
  end
end

IO.puts("Example 1:")
PWC.solution([[0,0],[2,0],[1,1],[2,1],[2,2]])

IO.puts("\nExample 2:")
PWC.solution([[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]])

IO.puts("\nExample 3:")
PWC.solution([[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]])

IO.puts("\nExample 4:")
PWC.solution([[0,0],[1,1]])

IO.puts("\nExample 5:")
PWC.solution([[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]])
