defmodule ExCoveralls.Post do
  @moduledoc """
  Handles general-purpose CI integration with coveralls.
  """
  alias ExCoveralls.Poster

  def execute(stats, options) do
    json = generate_json(stats, options)
    if options[:verbose] do
      IO.puts JSX.prettify!(json)
    end
    Poster.execute(json)
  end

  def generate_json(source_info, options) do
    JSX.encode!([
      repo_token: options[:token],
      service_name: options[:service_name],
      source_files: source_info,
      git: generate_git_info(options)
    ])
  end

  defp generate_git_info(options) do
    [head: [
       committer_name: options[:committer],
       message: options[:message]
      ],
      branch: options[:branch]
    ]
  end
end
