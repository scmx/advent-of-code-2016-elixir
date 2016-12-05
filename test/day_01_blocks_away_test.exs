defmodule Adventofcode.Day01BlocksAwayTest do
  use ExUnit.Case

  import Adventofcode.Day01BlocksAway
  import Adventofcode.TestHelpers

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
      with_puzzle_input "input/day_01_blocks_away.txt", fn input ->
        assert 253 = input |> blocks_away
      end
    end
  end

  describe "first_revisit" do
    test"R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East" do
      assert 4 = "R8, R4, R4, R8" |> first_revisit
    end

    test "L3 R2 R2 gives 3" do
      assert 0 = "L3, R3, R3, R3" |> first_revisit
    end

    test "R2, L2, R2, R2, R2, L2" do
      assert 2 = "R2, L2, R2, R2, R2, L2" |> first_revisit
    end

    test "with puzzle input" do
      with_puzzle_input "input/day_01_blocks_away.txt", fn input ->
        assert 126 = input |> first_revisit
      end
    end
  end
end
