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

  test "better_eight_char_pass_stream/1" do
    stream = "abc" |> better_eight_char_pass_stream
    assert [
      %Row{
        door_id: "abc", index: 3231929, position: 1, letter: "5",
        hash: "00000155f8105dff7f56ee10fa9b9abd"
      },
      %Row{
        door_id: "abc", index: 5357525, position: 4, letter: "e",
        hash: "000004e597bd77c5cd2133e9d885fe7e"
      },
    ] == stream |> Enum.take(2)
  end

  describe "better_eight_char_pass/1" do
    @tag timeout: 240000
    test "with example input" do
      assert "05ace8e3" = "abc" |> better_eight_char_pass
    end

    @tag timeout: 240000
    test "with puzzle input" do
      with_puzzle_input "input/day_05_eight_char_pass.txt", fn input ->
        assert "f2c730e5" = input |> better_eight_char_pass
      end
    end
  end
end
