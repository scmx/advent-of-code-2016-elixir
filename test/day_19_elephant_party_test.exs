defmodule Adventofcode.Day19ElephantPartyTest do
  use ExUnit.Case

  import Adventofcode.Day19ElephantParty

  describe "who_gets_all_the_presents/1" do
    test "for example, with five Elves, position 3 gets all the presents" do
      assert 3 = 5 |> who_gets_all_the_presents
    end

    @tag timeout: 60 * 60 * 1000
    test "with puzzle input" do
      assert 0 = 3014603 |> who_gets_all_the_presents
    end
  end
end
