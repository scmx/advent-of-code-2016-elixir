defmodule Adventofcode.Day04SectorSum do
  def sector_sum(instructions) when is_binary(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.filter(&real?/1)
    |> Enum.map(fn {_, _, sector_id, _} -> sector_id end)
    |> Enum.sum
  end

  def decrypt_sectors(instructions) when is_binary(instructions) do
    instructions
    |> String.strip
    |> String.split("\n")
    |> Enum.map(&parse_instruction/1)
    |> Enum.filter(&real?/1)
    |> Enum.map(fn {_, name, sector_id, _} -> {name, sector_id} end)
  end

  def sector_id_northpole_object_storage(instructions) do
    instructions
    |> decrypt_sectors
    |> Enum.find(fn {name, _} -> name == "northpole object storage" end)
    |> elem(1)
  end

  defp real?({encrypted_name, _, _, checksum}) do
    checksum == encrypted_name |> calculate_checksum
  end

  @regex ~r/([a-z-]+)-(\d+)\[([a-z]+)\]/
  defp parse_instruction(instruction) do
    [_, encrypted_name, sector, checksum] = Regex.run(@regex, instruction)
    sector_id = sector |> String.to_integer
    decrypted_name = {encrypted_name, sector_id} |> decrypt
    {encrypted_name, decrypted_name, sector_id, checksum}
  end

  defp calculate_checksum(encrypted_name) do
    encrypted_name
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

  def decrypt({encrypted_name, sector_id}) when is_binary(encrypted_name) do
    encrypted_name
    |> String.to_charlist
    |> do_decrypt(sector_id)
  end

  defp do_decrypt(chars, sector_id, result \\ [])
  defp do_decrypt([], _, result), do: result |> to_string
  defp do_decrypt([char | tail], sector_id, result),
    do: do_decrypt(tail, sector_id, result ++ [char |> shift_letter(sector_id)])

  defp shift_letter(?-, _), do: ?\s
  defp shift_letter(char, sector_id) do
    current = char - ?a
    max = ?z - ?a + 1
    ?a + rem(current + sector_id, max)
  end
end
