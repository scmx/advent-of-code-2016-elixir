defmodule Adventofcode.Day05EightCharPass do
  defmodule Row do
    defstruct [door_id: nil, index: 0, hash: nil, position: nil, letter: nil]
  end

  def eight_char_pass(door_id) do
    %Row{door_id: door_id}
    |> Stream.iterate(&increasing_index/1)
    |> Stream.map(&assign_hash/1)
    |> Stream.filter(&five_zeroes?/1)
    |> Enum.take(8)
    |> Enum.map(&String.at(&1.hash, 5))
    |> Enum.join("")
  end

  def increasing_index (row) do
    %{row | index: row.index + 1}
  end

  def assign_hash(row), do: %{row | hash: md5("#{row.door_id}#{row.index}")}

  def md5(string), do: string |> :erlang.md5 |> Base.encode16(case: :lower)

  defp five_zeroes?(%{hash: "00000" <> _}), do: true
  defp five_zeroes?(%{hash: _}), do: false
end
