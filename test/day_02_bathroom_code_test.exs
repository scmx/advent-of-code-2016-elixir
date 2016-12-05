defmodule Adventofcode.Day02BathroomCodeTest do
  use ExUnit.Case

  import Adventofcode.Day02BathroomCode
  import Adventofcode.TestHelpers

  describe "bathroom_code/1" do
    test "with example instructions" do
      assert "1985" =
        """
        ULL
        RRDDD
        LURDL
        UUUUD
        """ |> bathroom_code
    end

    test "with puzzle input" do
      with_puzzle_input "input/day_02_bathroom_code.txt", fn input ->
        assert "36629" = input |> bathroom_code
      end
    end
  end
end
