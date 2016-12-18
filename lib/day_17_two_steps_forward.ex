defmodule Adventofcode.Day17TwoStepsForward.Utils do
  def open_doors(hashed_passcode) do
    hashed_passcode
    |> String.graphemes
    |> Enum.zip("UDLR" |> String.graphemes)
    |> Enum.filter(&open?/1)
    |> Enum.map(&elem(&1, 1))
  end

  defp open?({"b", _}), do: true
  defp open?({"c", _}), do: true
  defp open?({"d", _}), do: true
  defp open?({"e", _}), do: true
  defp open?({"f", _}), do: true
  defp open?(_), do: false

  def hash(string), do: string |> md5 |> String.slice(0, 4)

  def md5(string), do: string |> :erlang.md5 |> Base.encode16(case: :lower)
end

defmodule Adventofcode.Day17TwoStepsForward.Traveler do
  import Adventofcode.Day17TwoStepsForward.Utils

  defstruct [passcode: nil, x: 0, y: 0]

  def travel(%__MODULE__{x: 3, y: 3} = traveler) do
    [traveler]
  end

  def travel(%__MODULE__{passcode: passcode} = traveler) do
    traveler
    |> fork
    |> Enum.flat_map(&travel/1)
  end

  def fork(%__MODULE__{passcode: passcode} = traveler) do
    passcode
    |> hash
    |> open_doors
    |> Enum.map(&neighbour(&1, traveler))
    |> Enum.filter(&possible_position?/1)
  end

  defp neighbour("U", t), do: %{t | y: t.y - 1, passcode: t.passcode <> "U"}
  defp neighbour("D", t), do: %{t | y: t.y + 1, passcode: t.passcode <> "D"}
  defp neighbour("L", t), do: %{t | x: t.x - 1, passcode: t.passcode <> "L"}
  defp neighbour("R", t), do: %{t | x: t.x + 1, passcode: t.passcode <> "R"}

  def possible_position?(%{y: y}) when y < 0, do: false
  def possible_position?(%{y: y}) when y > 3, do: false
  def possible_position?(%{x: x}) when x < 0, do: false
  def possible_position?(%{x: x}) when x > 3, do: false
  def possible_position?(_), do: true
end

defmodule Adventofcode.Day17TwoStepsForward do
  alias Adventofcode.Day17TwoStepsForward.Traveler

  def shortest_path(passcode) do
    %Traveler{passcode: passcode}
    |> Traveler.travel
    |> Enum.map(&(&1.passcode))
    |> Enum.sort_by(&(&1 |> String.length))
    |> Enum.map(&String.trim(&1, passcode))
    |> Enum.find(&(&1))
  end
end
