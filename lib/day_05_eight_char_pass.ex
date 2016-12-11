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

  def better_eight_char_pass(door_id) do
    door_id
    |> better_eight_char_pass_stream
    |> Enum.reduce_while(%{}, &password_reducer/2)
  end

  def better_eight_char_pass_stream(door_id) do
    %Row{door_id: door_id}
    |> Stream.iterate(&increasing_index/1)
    |> Stream.map(&assign_hash/1)
    |> Stream.filter(&five_zeroes_and_pos?/1)
    |> Stream.map(&assign_position_and_letter/1)
  end

  defp five_zeroes_and_pos?(%{hash: "000000" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000001" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000002" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000003" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000004" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000005" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000006" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: "000007" <> _}), do: true
  defp five_zeroes_and_pos?(%{hash: _}), do: false

  defp assign_position_and_letter(row) do
    position = row.hash |> String.at(5) |> String.to_integer
    letter = row.hash |> String.at(6)
    %{row | position: position, letter: letter}
  end

  defp password_reducer(line, acc) do
    cond do
      acc |> password_complete? -> {:halt, acc |> password_combine}
      acc |> Map.has_key?(line.position) -> {:cont, acc}
      true -> {:cont, acc |> Map.put(line.position, line.letter)}
    end
  end

  defp password_complete?(lines),
    do: 0..7 |> Enum.all?(&Map.has_key?(lines, &1))

  defp password_combine(lines),
    do: 0..7 |> Enum.reduce("", &"#{&2}#{lines |> Map.get(&1)}")
end
