defmodule Adventofcode.Day01BlocksAway do
  def blocks_away(instructions),
    do: do_blocks_away(instructions |> decode)

  def do_blocks_away(instructions),
    do: instructions |> get_end_pos |> get_distance

  def get_distance({x, y}), do: abs(x) + abs(y)

  def get_end_pos(instructions, position \\ {0, 0}, direction \\ :north)
  def get_end_pos([], {x, y}, _dir), do: {x, y}
  def get_end_pos([{turn, steps} | tail], {x, y}, dir),
    do: get_end_pos([{steps} | tail], {x, y}, update_direction(turn, dir))
  def get_end_pos([{steps} | tail], {x, y}, dir),
    do: get_end_pos(tail, update_position({x, y}, steps, dir), dir)

  def update_position({x, y}, steps, :north), do: {x, y - steps}
  def update_position({x, y}, steps, :east), do: {x + steps, y}
  def update_position({x, y}, steps, :south), do: {x, y + steps}
  def update_position({x, y}, steps, :west), do: {x - steps, y}

  def update_direction(:R, :north), do: :east
  def update_direction(:R, :east), do: :south
  def update_direction(:R, :south), do: :west
  def update_direction(:R, :west), do: :north
  def update_direction(:L, :north), do: :west
  def update_direction(:L, :east), do: :north
  def update_direction(:L, :south), do: :east
  def update_direction(:L, :west), do: :south

  def decode(instructions) when is_binary(instructions),
    do: do_decode(instructions |> String.split(", "))
  def decode(instructions) when is_list(instructions),
    do: do_decode(instructions)

  defp do_decode(instructions, result \\ [])
  defp do_decode([], result), do: result |> Enum.reverse
  defp do_decode(["R" <> num | tail], result),
    do: do_decode(tail, [{:R, num |> String.to_integer } | result])
  defp do_decode(["L" <> num | tail], result),
    do: do_decode(tail, [{:L, num |> String.to_integer } | result])
end
