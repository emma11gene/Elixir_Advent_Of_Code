defmodule Day2 do
  @moduledoc """
  Documentation for Day2
    day 2 of AOC:
    par1
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
  part2
  While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

  The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

  Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

  Given the same example list from above:

  1-3 a: abcde is valid: position 1 contains a and position 3 does not.
  1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
  2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
  How many passwords are valid according to the new interpretation of the policies?
  """

  def read_file do
    File.read!("source_files/day_2_passwords.ex")
  end

  def convert_input_to_map(password_input) do
    password_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn password_policy ->
      Regex.named_captures(
        ~r/^(?<policy_arg_1>[\d]+)-(?<policy_arg_2>[\d]+)\s(?<policy>[a-z]):\s(?<password>[a-z]+)/,
        password_policy
      )
    end)
  end

  @doc """
  iex> Day2.get_valid_passwords([%{"policy_arg_2" => "2", "policy_arg_1" => "1", "password" => "lmrr", "policy" => "r"}, %{"policy_arg_2" => "2", "policy_arg_1" => "1", "password" => "lmrrr", "policy" => "r"}])
  ["lmrrr"]
  """
  def get_valid_passwords_part_1(pass_policy_map) do
    pass_policy_map
    |> Enum.filter(fn pass_policy ->
      count_of_policy_chars_in_pass =
        String.graphemes(pass_policy["password"])
        |> Enum.count(&(&1 == pass_policy["policy"]))

      count_of_policy_chars_in_pass >= String.to_integer(pass_policy["policy_arg_1"]) and
        count_of_policy_chars_in_pass <= String.to_integer(pass_policy["policy_arg_2"])
    end)
  end

  def get_valid_passwords_part_2(pass_policy_map) do
    pass_policy_map
    |> Enum.filter(fn pass_policy ->
      position_1 = String.to_integer(pass_policy["policy_arg_1"]) - 1
      position_2 = String.to_integer(pass_policy["policy_arg_2"]) - 1
      password = pass_policy["password"]
      policy_char = pass_policy["policy"]

      (String.at(password, position_1) == policy_char and
         String.at(password, position_2) != policy_char) or
        (String.at(password, position_2) ==
           policy_char and String.at(password, position_1) != policy_char)
    end)
  end

  def count_of_valid_passwords(invalid_passwords) do
    invalid_passwords
    |> Enum.count()
  end

  def run_part1_solution do
    read_file()
    |> convert_input_to_map()
    |> get_valid_passwords_part_1()
    |> count_of_valid_passwords()
  end

  def run_part2_solution do
    read_file()
    |> convert_input_to_map()
    |> get_valid_passwords_part_2()
    |> count_of_valid_passwords()
  end
end
