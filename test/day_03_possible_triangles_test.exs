defmodule Adventofcode.Day03PossibleTrianglesTest do
  use ExUnit.Case

  import Adventofcode.Day03PossibleTriangles
  import Adventofcode.TestHelpers

  describe "possible_triangles/1" do
    test "impossible cases" do
      assert [] = [[5, 10, 25]] |> possible_triangles
      assert [] = [[5, 25, 10]] |> possible_triangles
      assert [] = [[10, 5, 25]] |> possible_triangles
      assert [] = [[10, 25, 5]] |> possible_triangles
      assert [] = [[25, 5, 10]] |> possible_triangles
      assert [] = [[25, 10, 5]] |> possible_triangles
      assert [] = [[15, 10, 25]] |> possible_triangles
      assert [] = [[15, 25, 10]] |> possible_triangles
      assert [] = [[10, 15, 25]] |> possible_triangles
      assert [] = [[10, 25, 15]] |> possible_triangles
      assert [] = [[25, 15, 10]] |> possible_triangles
      assert [] = [[25, 10, 15]] |> possible_triangles
      assert [] = [[4, 2, 2]] |> possible_triangles
      assert [] = [[2, 4, 2]] |> possible_triangles
      assert [] = [[2, 2, 4]] |> possible_triangles
    end


    test "possible cases" do
      assert [[3, 2, 2]] = [[3, 2, 2]] |> possible_triangles
      assert [[2, 3, 2]] = [[2, 3, 2]] |> possible_triangles
      assert [[2, 2, 3]] = [[2, 2, 3]] |> possible_triangles
    end

    test "newline cases" do
      assert 0 = "2 3 7\n9 4 3" |> possible_triangles
      assert 0 = "9 4 3\n2 3 7\n" |> possible_triangles
      assert 1 = "5 5 5\n2 3 7\n" |> possible_triangles
      assert 1 = "9 4 3\n7 7 7\n2 3 7" |> possible_triangles
    end

    test "only one for 2 3 7\n9 4 3\n7 4 5" do
      assert 1 = "2 3 7\n9 4 3\n7 4 5" |> possible_triangles
    end

    test "all for   3  3    3 \n 9    9 9   " do
      assert 2 = "  3  3    3 \n 9    9 9   " |> possible_triangles
    end

    test "with puzzle input" do
      with_puzzle_input "input/day_03_possible_triangles.txt", fn input ->
        assert 1032 = input |> possible_triangles
      end
    end
  end
end
