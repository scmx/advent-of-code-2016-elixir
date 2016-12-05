defmodule Adventofcode.Day01BlocksAway do
  def blocks_away(instructions),
    do: instructions |> decode |> get_end_pos |> get_distance

  def first_revisit(instructions),
    do: instructions |> decode |> get_first_revisit_pos |> get_distance

  def get_distance({x, y}), do: abs(x) + abs(y)

  def get_end_pos(
    instructions,
    direction \\ :north,
    positions \\ [{0, 0}])
  def get_end_pos([], _dir, [{x, y} | _tail]), do: {x, y}
  def get_end_pos([{turn, steps} | tail], dir, positions),
    do: get_end_pos([{steps} | tail], update_direction(turn, dir), positions)
  def get_end_pos([{0}  | tail], dir, positions),
    do: get_end_pos(tail, dir, positions)
  def get_end_pos([{steps} | tail], dir, positions),
    do: get_end_pos([{steps - 1} | tail], dir, positions |> move(dir))

  def get_first_revisit_pos(
    instructions,
    direction \\ :north,
    positions \\ [{0, 0}])
  def get_first_revisit_pos([], _dir, [{x, y} | _tail]), do: {x, y}
  def get_first_revisit_pos([{turn, steps} | tail], dir, positions),
    do: get_first_revisit_pos([{steps} | tail], update_direction(turn, dir), positions)
  def get_first_revisit_pos([{0}  | tail], dir, [last | rest] = positions) do
    if rest |> Enum.member?(last) do
      get_first_revisit_pos([], dir, positions)
    else
      get_first_revisit_pos(tail, dir, positions)
    end
  end

  def get_first_revisit_pos([{steps} | tail], dir, [last | rest] = positions) do
    if rest |> Enum.member?(last) do
      get_first_revisit_pos([], dir, positions)
    else
      get_first_revisit_pos([{steps - 1} | tail], dir, positions |> move(dir))
    end
  end

  def move([{x, y} | tail], :north), do: [{x, y - 1}, {x, y} | tail]
  def move([{x, y} | tail], :east), do: [{x + 1, y}, {x, y} | tail]
  def move([{x, y} | tail], :south), do: [{x, y + 1}, {x, y} | tail]
  def move([{x, y} | tail], :west), do: [{x - 1, y}, {x, y} | tail]

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
