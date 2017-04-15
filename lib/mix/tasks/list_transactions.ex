# Create a task to run the BankStatement application
#  via CLI: `mix`.
defmodule Mix.Tasks.ListTransactions do
  # Import Mix module dependency.
  use Mix.Task

  # Run application. Ignore argument and suppress warning with `_`. View task
  #  description `@shortdoc` via `mix help` (CLI).
  @shortdoc "List transactions from CSV file."
  def run(_) do
    BankStatement.list_transactions |> IO.inspect
  end
end
