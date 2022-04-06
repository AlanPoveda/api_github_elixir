defmodule GithubReposTest do
  use ExUnit.Case

  import Tesla.Mock


  describe "user_repos/1" do
    test "When the user has repos, return the repos" do
      username = "AlanPoveda"

      response = [%{"id" => 1, "name" => "Repo 1"},%{"id" => 2, "name" => "Repo 2"}]

      expected_response = {:ok, response}

      mock(fn %{method: :get, url: "https://api.github.com/users/alanpoveda/repos"} ->
        %Tesla.Env{status: 200, body: response}
      end)

      assert GithubRepos.user_repos(username) == expected_response
    end

  end

end
