defmodule Adventofcode.Day05EightCharPassTest do
  use ExUnit.Case

  import Adventofcode.Day05EightCharPass
  import Adventofcode.TestHelpers

  alias Adventofcode.Day05EightCharPass.Row

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

  test "increasing_index/1" do
    stream = %Row{door_id: "abc"} |> Stream.iterate(&increasing_index/1)
    assert [
      %Row{door_id: "abc", index: 0},
      %Row{door_id: "abc", index: 1},
      %Row{door_id: "abc", index: 2},
    ] = stream |> Enum.take(3)
  end

  test "assign_hash/1" do
    stream =
      %Row{door_id: "abc"}
      |> Stream.iterate(&increasing_index/1)
      |> Stream.map(&assign_hash/1)
    assert [
      %Row{door_id: "abc", index: 0},
    ] = stream |> Enum.take(1)
  end

  describe "md5/1" do
    test "hashing abc3231929 gives 00000155f8105dff7f56ee10fa9b9abd" do
      assert "00000155f8105dff7f56ee10fa9b9abd" = "abc3231929" |> md5
    end
  end
end
