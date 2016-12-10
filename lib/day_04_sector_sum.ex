defmodule Adventofcode.Day04SectorSum do
  def sector_sum(instructions) when is_binary(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.filter(&real?/1)
    |> Enum.map(fn {_, sector_id, _} -> sector_id end)
    |> Enum.sum
  end

  defp real?({decrypted_name, _, checksum}) do
    decrypted_name == checksum
  end

  @regex ~r/([a-z-]+)-(\d+)\[([a-z]+)\]/
  defp parse_instruction(instruction) do
    [_, encrypted_name, sector_id, checksum] = Regex.run(@regex, instruction)
    {encrypted_name |> decrypt, sector_id |> String.to_integer, checksum}
  end

  defp decrypt(name) do
    name
    |> String.replace(~r/[^a-z]/, "")
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {letter, list} -> {letter, list |> Enum.count} end)
    |> Enum.sort_by(fn {_, count} -> count end, &>=/2)
    |> Enum.take(5)
    |> Enum.map(fn {letter, _} -> letter end)
    |> Enum.join("")
  end
end
