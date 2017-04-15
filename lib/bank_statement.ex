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
  end

  # Callback to handle parsing CSV content.
  # Private functions are defined with `defp`.
  defp parse(string) do
    CSV.parse_string(string)
  end

  # Filter out cells from each row of a set of CSV columns.
  defp filter(rows) do
    # Drop first element, the "Account Number", from the data.
    # Pass each row (`&1`) into an anonymous function (`&`, short for
    #  `fn(row) ->`)  that calls `Enum.drop` on the first element.
    Enum.map(rows, &Enum.drop(&1, 1))
  end

end
