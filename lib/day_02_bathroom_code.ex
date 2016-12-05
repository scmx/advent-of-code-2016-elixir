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
end
