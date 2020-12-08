defmodule Day2 do
  @moduledoc """
  Documentation for Day2
    day 2 of AOC:
  Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.

  The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.

  Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

  To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

  For example, suppose you have the following list:

  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

  In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

  How many passwords are valid according to their policies?
  """

  @test_source """
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  """

  @doc """
  iex> Day2.say_hello()
  "hello"
  """
  def say_hello do
    IO.inspect("hello")
  end

  def read_file do
    File.read!("source_files/day_2_passwords.ex")
  end

  # def convert_password_and_policy_to_map(password_input) do
  #   password_input
  #   |> String.split("\n", trim: true)
  #   |> Enum.map(fn password_policy ->
  #     password_policy_map =
  #       Regex.named_captures(
  #         ~r/^(?<min>[\d]+)-(?<max>[\d]+)\s(?<policy>[a-z]):\s(?<password>[a-z]+)/,
  #         password_policy
  #       )

  #     count_of_required_char_in_password =
  #       String.graphemes(password_policy_map["password"])
  #       |> Enum.count(&(&1 == password_policy_map["policy"]))

  #     if(
  #       count_of_required_char_in_password >= String.to_integer(password_policy_map["min"]) and
  #         count_of_required_char_in_password <= String.to_integer(password_policy_map["max"])
  #     ) do
  #       nil
  #     else
  #       password_policy_map["password"]
  #     end
  #   end)
  #   |> IO.inspect()
  # end

  @doc """
  iex> Day2.convert_password_and_policy_to_map(#{inspect(@test_source)})
   ...>       [
   ...>           %{
   ...>             "max" => "3",
   ...>             "min" => "1",
   ...>             "password" => "abcde",
   ...>             "policy" => "a"
   ...>           },
   ...>           %{
   ...>             "max" => "3",
   ...>             "min" => "1",
   ...>             "password" => "cdefg",
   ...>             "policy" => "b"
   ...>           },
   ...>           %{
   ...>             "max" => "9",
   ...>             "min" => "2",
   ...>             "password" => "ccccccccc",
   ...>             "policy" => "c"
   ...>           }
   ...>         ]
  """
  def convert_password_and_policy_to_map(password_input) do
    password_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn password_policy ->
      Regex.named_captures(
        ~r/^(?<min>[\d]+)-(?<max>[\d]+)\s(?<policy>[a-z]):\s(?<password>[a-z]+)/,
        password_policy
      )
    end)
  end

  @doc """
  iex> Day2.get_invalid_passwords([%{"max" => "2", "min" => "1", "password" => "lmrr", "policy" => "r"}, %{"max" => "2", "min" => "1", "password" => "lmrrr", "policy" => "r"}])
  ["lmrrr"]
  """
  def get_invalid_passwords(pass_policy_map) do
    pass_policy_map
    |> Enum.map(fn pass_policy ->
      count_of_policy_chars_in_pass =
        String.graphemes(pass_policy["password"])
        |> Enum.count(&(&1 == pass_policy["policy"]))

      if(
        count_of_policy_chars_in_pass < String.to_integer(pass_policy["min"]) or
          count_of_policy_chars_in_pass > String.to_integer(pass_policy["max"])
      ) do
        pass_policy["password"]
      end
    end)
  end

  def count_of_invalid_passwords(invalid_passwords) do
    invalid_passwords
    |> IO.inspect()
  end

  def run do
    read_file()
    |> convert_password_and_policy_to_map()
    |> IO.inspect()

    # |> get_invalid_passwords()
    # |> count_of_invalid_passwords()
  end
end
