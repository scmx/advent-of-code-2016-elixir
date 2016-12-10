defmodule Adventofcode.Day04SectorSumTest do
  use ExUnit.Case

  import Adventofcode.Day04SectorSum
  import Adventofcode.TestHelpers

  describe "sector_sum/1" do
    test "is a real room because the most common letters are a (5), b (3), and
    then a tie between x, y, and z, which are listed alphabetically." do
      assert 123 = "aaaaa-bbb-z-y-x-123[abxyz]" |> sector_sum
    end

    test "is a real room because although the letters are all tied (1 of each), the first five are listed alphabetically." do
      assert 987 = "a-b-c-d-e-f-g-h-987[abcde]" |> sector_sum
    end

    test "is a real room" do
      assert 404 = "not-a-real-room-404[oarel]" |> sector_sum
    end

    test "is not a real room" do
      assert 0 = "totally-real-room-200[decoy]" |> sector_sum
    end

    test "with puzzle input" do
      with_puzzle_input "input/day_04_sector_sum.txt", fn input ->
        assert 278221 = input |> sector_sum
      end
    end
  end
end
