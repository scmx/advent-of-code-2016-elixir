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
end
