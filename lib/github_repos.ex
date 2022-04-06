defmodule GithubRepos do

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def user_repos(login) do
    "/users/#{login}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: response}}), do: {:ok, response}

  defp handle_get({:ok, %Tesla.Env{status: 404}}), do: {:error, "Not found"}

  defp handle_get({:error, _reason}), do: {:error, "Error"}
end
