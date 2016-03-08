defmodule Issues.CLI do
  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      { [help: true], _, _ } -> :help
      { [], [user, project, count], _ } ->
        { user, project, String.to_integer(count) }
      { [], [user, project], _ } -> { user, project, 4 }
    end
  end

  def process(:help) do
    IO.puts """
    Usage: issues <user> <project> [ count | 4 ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
  end
end
