# Create a task to run the BankStatement application
#  via CLI: `mix`.
defmodule Mix.Tasks.ListTransactions do
  # Import Mix module dependency.
  use Mix.Task

  # Run application. Ignore argument and suppress warning with `_`.
  def run(_) do
    Budget.list_transactions |> IO.inspect
  end
end
