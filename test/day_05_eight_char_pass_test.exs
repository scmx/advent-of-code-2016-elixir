defmodule Adventofcode.Day05EightCharPassTest do
  use ExUnit.Case

  import Adventofcode.Day05EightCharPass
  import Adventofcode.TestHelpers

  describe "eight_char_pass/1" do
    test "with example input" do
      assert "18f47a30" = "abc" |> eight_char_pass
    end

    test "with puzzle input" do
      with_puzzle_input "input/day_05_eight_char_pass.txt", fn input ->
        assert "d4cd2ee1" = input |> eight_char_pass
      end
    end
  end

  describe "five_zero_hashes/1" do
    test "first index that produces a hash with five zeroes" do
      assert [
        "00000155f8105dff7f56ee10fa9b9abd",
        "000008f82c5b3924a1ecbebf60344e00",
      ] == "abc" |> five_zero_hashes |> Enum.take(2)
    end
  end

  describe "md5/1" do
    test "hashing abc3231929 gives 00000155f8105dff7f56ee10fa9b9abd" do
      assert "00000155f8105dff7f56ee10fa9b9abd" = "abc3231929" |> md5
    end
  end
end
