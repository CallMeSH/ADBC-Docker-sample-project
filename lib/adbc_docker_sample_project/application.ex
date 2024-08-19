defmodule AdbcDockerSampleProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AdbcDockerSampleProjectWeb.Telemetry,
      AdbcDockerSampleProject.Repo,
      {DNSCluster, query: Application.get_env(:adbc_docker_sample_project, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AdbcDockerSampleProject.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AdbcDockerSampleProject.Finch},
      # Start a worker by calling: AdbcDockerSampleProject.Worker.start_link(arg)
      # {AdbcDockerSampleProject.Worker, arg},
      # Start to serve requests, typically the last entry
      AdbcDockerSampleProjectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AdbcDockerSampleProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AdbcDockerSampleProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
