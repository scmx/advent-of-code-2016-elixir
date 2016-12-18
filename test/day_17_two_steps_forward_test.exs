defmodule Adventofcode.Day17TwoStepsForwardTest do
  use ExUnit.Case

  import Adventofcode.Day17TwoStepsForward
  import Adventofcode.Day17TwoStepsForward.Utils
  import Adventofcode.TestHelpers

  describe "open_doors/1" do
    test "ced9, up, down, left are open, and right is closed" do
      assert "ced9" = "hijkl" |> hash
      assert "UDL" = "ced9" |> open_doors |> Enum.join("")
    end

    test "f2bc, which indicates that you can go back up, left (but that's a wall), or right" do
      assert "f2bc" = "hijklD" |> hash
      assert "ULR" = "f2bc" |> open_doors |> Enum.join("")
    end

    test "hashing hijklDU to get 528e" do
      assert "528e" = "hijklDU" |> hash
      assert "R" = "528e" |> open_doors |> Enum.join("")
    end

    test "after going DUR, all doors lock" do
      assert "818a" = "hijklDUR" |> hash
      assert "" = "818a" |> open_doors |> Enum.join("")
    end
  end

  describe "shortest_path/1" do
    @tag :skip
    test "If your passcode were ihgpwlah, the shortest path would be DDRRRD" do
      assert "DDRRRD" = "ihgpwlah" |> shortest_path
    end

    @tag :skip
    test "With kglvqrro, the shortest path would be DDUDRLRRUDRD" do
      assert "DDUDRLRRUDRD" = "kglvqrro" |> shortest_path
    end

    @tag :skip
    test "With ulqzkmiv, the shortest would be DRURDRUDDLLDLUURRDULRLDUUDDDRR" do
      assert "DRURDRUDDLLDLUURRDULRLDUUDDDRR" = "ulqzkmiv" |> shortest_path
    end
  end
end

defmodule Adventofcode.Day17TwoStepsForward.TravlerTest do
  use ExUnit.Case

  import Adventofcode.Day17TwoStepsForward

  alias Adventofcode.Day17TwoStepsForward.Traveler

  describe "fork/1" do
    test "there are no \"up\" or \"left\" doors to be open, so your only choice is down." do
      traveler = %Traveler{passcode: "hijkl", x: 0, y: 0}
      assert [
        %Traveler{passcode: "hijklD", x: 0, y: 1},
      ] = traveler |> Traveler.fork
    end

    test "you can go back up, left (but that's a wall), or right" do
      traveler = %Traveler{passcode: "hijklD", x: 0, y: 1}
      assert [
        %Traveler{passcode: "hijklDU", x: 0, y: 0},
        %Traveler{passcode: "hijklDR", x: 1, y: 1},
      ] = traveler |> Traveler.fork
    end

    test "Going right means hashing hijklDR to get 5745 - all doors closed and locked" do
      traveler = %Traveler{passcode: "hijklDR", x: 1, y: 1}
      assert [] = traveler |> Traveler.fork
    end
  end

  describe "travel/1" do
    @tag :skip
    test "after going DUR, all doors lock" do
      traveler = %Traveler{passcode: "hijkl"}
      assert [] == traveler |> Traveler.travel
    end
  end

  describe "shortest_path/1" do
    test "after going DUR, all doors lock" do
      assert nil == "hijkl" |> shortest_path
    end

    test "If your passcode were ihgpwlah, the shortest path would be DDRRRD" do
      assert "DDRRRD" = "ihgpwlah" |> shortest_path
    end

    test "With kglvqrro, the shortest path would be DDUDRLRRUDRD" do
      assert "DDUDRLRRUDRD" = "kglvqrro" |> shortest_path
    end

    test "With ulqzkmiv, the shortest would be DRURDRUDDLLDLUURRDULRLDUUDDDRR" do
      assert "DRURDRUDDLLDLUURRDULRLDUUDDDRR" = "ulqzkmiv" |> shortest_path
    end

    test "with puzzle input" do
      assert "RLDRUDRDDR" = "yjjvjgan" |> shortest_path
    end
  end
end
