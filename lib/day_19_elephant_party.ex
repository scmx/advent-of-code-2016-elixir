defmodule Adventofcode.Day19ElephantParty do
  def who_gets_all_the_presents(elf_count) do
    do_rotate(1..elf_count |> Enum.to_list)
  end

  defp do_rotate([elf]), do: elf
  defp do_rotate([elf1, elf2 | tail]), do: do_rotate(tail ++ [elf1])
end
