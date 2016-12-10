defmodule Adventofcode.Day05EightCharPass do
  def eight_char_pass(door_id) do
    door_id
    |> five_zero_hashes
    |> Stream.map(&String.at(&1, 5))
    |> Enum.take(8)
    |> Enum.join("")
  end

  def five_zero_hashes(door_id) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&("#{door_id}#{&1}"))
    |> Stream.map(&md5/1)
    |> Stream.filter(&five_zeroes?/1)
  end

  def md5(string) do
    string |> :erlang.md5 |> Base.encode16(case: :lower)
  end

  defp five_zeroes?("00000" <> _), do: true
  defp five_zeroes?(_), do: false
end
