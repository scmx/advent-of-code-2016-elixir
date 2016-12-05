defmodule Adventofcode.Day02BathroomCode do
  # Position as a grid
  # 1 2 3    {0,0} {1,0} {2,0}
  # 4 5 6    {0,1} {1,1} {2,1}
  # 7 8 9    {0,2} {1,2} {2,2}
  # Thus the starting position "5" is...
  @start_pos {1, 1}
  @grid_width 3
  @grid_height 3
  @max_x @grid_width - 1
  @max_y @grid_height - 1

  def bathroom_code(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> do_bathroom_code
  end

  defp do_bathroom_code(instructions, position \\ @start_pos, result \\ "")
  defp do_bathroom_code([], _, result), do: result
  defp do_bathroom_code([[] | tail], position, result),
    do: do_bathroom_code(tail, position, result <> button_from_pos(position))
  defp do_bathroom_code([[direction | rest] | tail], position, result),
    do: do_bathroom_code([rest | tail], move(direction, position), result)

  defp button_from_pos({x, y}), do: "#{@grid_height * y + x + 1}"

  defp move(?D, {x, @max_y}), do: {x, @max_y}
  defp move(?D, {x, y}), do: {x, y + 1}
  defp move(?R, {@max_x, y}), do: {@max_x, y}
  defp move(?R, {x, y}), do: {x + 1, y}
  defp move(?L, {0, y}), do: {0, y}
  defp move(?L, {x, y}), do: {x - 1, y}
  defp move(?U, {x, 0}), do: {x, 0}
  defp move(?U, {x, y}), do: {x, y - 1}


  # Position as a grid
  #     1                     {0,-2}
  #   2 3 4           {-1,-1} {0,-1} {1,-1}
  # 5 6 7 8 9  {-2,0} {-1, 0} {0, 0} {1, 0} {2,0}
  #   A B C           {-1, 1} {0, 1} {1, 1}
  #     D                     {0, 2}
  # Thus the starting position "5" is...
  @start_pos {-2, 0}

  def insane_code(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> do_insane_code
  end

  defp do_insane_code(instructions, position \\ @start_pos, result \\ "")
  defp do_insane_code([], _, result), do: result
  defp do_insane_code([[] | tail], position, result),
    do: do_insane_code(tail, position, result <> insane_button_pos(position))
  defp do_insane_code([[direction | rest] | tail], position, result),
    do: do_insane_code([rest | tail], insane_move(direction, position), result)

  defp insane_move(?D, {x, y}) when abs(x) + abs(y + 1) > 2, do: {x, y}
  defp insane_move(?D, {x, y}), do: {x, y + 1}
  defp insane_move(?R, {x, y}) when abs(x + 1) + abs(y) > 2, do: {x, y}
  defp insane_move(?R, {x, y}), do: {x + 1, y}
  defp insane_move(?L, {x, y}) when abs(x - 1) + abs(y) > 2, do: {x, y}
  defp insane_move(?L, {x, y}), do: {x - 1, y}
  defp insane_move(?U, {x, y}) when abs(x) + abs(y - 1) > 2, do: {x, y}
  defp insane_move(?U, {x, y}), do: {x, y - 1}

  defp get_distance({x, y}), do: abs(x) + abs(y)

  defp insane_button_pos({x, y}) do
    case {x, y} do
      {0, -2} -> "1"
      {-1, -1} -> "2"
      {0, -1} -> "3"
      {1, -1} -> "4"
      {-2, 0} -> "5"
      {-1, 0} -> "6"
      {0, 0} -> "7"
      {1, 0} -> "8"
      {2, 0} -> "9"
      {-1, 1} -> "A"
      {0, 1} -> "B"
      {1, 1} -> "C"
      {0, 2} -> "D"
    end
  end
end
