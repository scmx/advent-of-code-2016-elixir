defmodule Adventofcode.Day01BlocksAwayTest do
  use ExUnit.Case

  import Adventofcode.Day01BlocksAway

  describe "blocks_away/1" do
    test "following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away" do
      assert 5 = "R2, L3" |> blocks_away
    end

    test "R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away" do
      assert 2 = "R2, R2, R2" |> blocks_away
    end

    test "R5, L5, R5, R3 leaves you 12 blocks away" do
      assert 12 = "R5, L5, R5, R3" |> blocks_away
    end

    test "with puzzle input" do
      assert 253 = read_puzzle_input |> blocks_away
    end
  end

  defp read_puzzle_input(path \\ "input/day_01_blocks_away.txt") do
    path
    |> File.read!
    |> String.trim
  end
end
