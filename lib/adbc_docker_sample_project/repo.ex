defmodule AdbcDockerSampleProject.Repo do
  use Ecto.Repo,
    otp_app: :adbc_docker_sample_project,
    adapter: Ecto.Adapters.Postgres
end
