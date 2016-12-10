defmodule Adventofcode.Day03PossibleTriangles do
  def possible_triangles(instructions) when is_binary(instructions) do
    instructions
    |> parse_into_triangles
    |> possible_triangles
    |> length
  end

  def possible_triangles(triangles) when is_list(triangles) do
    triangles
    |> Enum.filter(&possible_triangle?/1)
  end

  def parse_into_triangles(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_triangle/1)
  end

  defp parse_triangle(instruction) do
   instruction
    |> String.strip
    |> String.replace(~r/\s+/, " ")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp possible_triangle?([x, y, z]) when x + y <= z, do: false
  defp possible_triangle?([x, y, z]) when x + z <= y, do: false
  defp possible_triangle?([x, y, z]) when y + z <= x, do: false
  defp possible_triangle?(_), do: true

  def vertical_triangles(instructions) when is_binary(instructions) do
    instructions
    |> parse_into_triangles
    |> vertical_triangles
    |> possible_triangles
    |> length
  end

  def vertical_triangles(instructions) when is_list(instructions) do
    instructions
    |> parse_vertical_triangles
  end

  defp parse_vertical_triangles(instructions) do
    instructions
    |> Enum.chunk(3)
    |> Enum.flat_map(&transpose_columns/1)
  end

  defp transpose_columns(lists, result \\ [])
  defp transpose_columns([[], [], []], result), do: result |> Enum.reverse
  defp transpose_columns([[h1 | t1], [h2 | t2], [h3 | t3]], result),
    do: transpose_columns([t1, t2, t3], [[h1, h2, h3] | result])
end
