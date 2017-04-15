defmodule BankStatement do
  @moduledoc """
  Demo Elixir application which prettifies and sorts bank statement CSV data.
  """

  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  Hello world, indeed.

  ## Examples

      iex> BankStatement.hello
      :world

  """
  def list_transactions do
    # Bang-read returns content, or, raises an error if file is not found
    #  or is not readable. It does not return a tuple.
    File.read!("lib/transactions.csv")
    |> parse
    |> filter
    |> normalize
    |> sort
  end

  # Callback to handle parsing CSV content.
  # Private functions are defined with `defp`.
  defp parse(string) do
    # Replace all return chars with a blank string.
    # Pass result into aliased CSV library.
    string
    |> String.replace("\r", "")
    |> CSV.parse_string
  end

  # Filter out cells from each row of a set of CSV columns.
  defp filter(rows) do
    # Drop first element, the "Account Number", from the data.
    # Pass each row (`&1`) into an anonymous function (`&`, short for
    #  `fn(row) ->`)  that calls `Enum.drop` on the first element.
    Enum.map(rows, &Enum.drop(&1, 1))
  end

  # Prettify the rows of the statement.
  defp normalize(rows) do
    # Convert string element to number.
    Enum.map(rows, &parse_amount(&1))
  end

  # Extract amount from each row data.
  # Use function definition's parameters to declare and locate the amount
  #  column, as opposed to parsing a row to get the 3rd col.
  defp parse_amount([date, description, amount]) do
    [date, description, parse_to_float(amount)]
  end

  # Turn a string into a floating point number. Return absolute value of
  #  number, to avoid any floating point notation.
  def parse_to_float(string) do
    string
    |> String.to_float
    |> abs
  end

  # Sort the CSV according to ascending order of amount.
  defp sort(rows) do
    Enum.sort(rows, &sort_asc_by_amount(&1, &2))
  end

  # Callback to sort row data by amount column. Define previous and next amount
  #  values in function definition argument list, ignoring the first two cells
  #  of the rows with the special underscore char.
  defp sort_asc_by_amount([_, _, previous_amount], [_, _, next_amount]) do
    previous_amount < next_amount
  end

end
