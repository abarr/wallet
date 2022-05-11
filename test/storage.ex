defmodule Wallet.Storage do
  @doc """
  Reset the event store and read store databases.
  """
  def reset! do
    :ok = Application.stop(:wallet)

    reset_eventstore!()
    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:wallet)
  end

  defp reset_eventstore! do
    {:ok, conn} =
      Wallet.EventStore.config()
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore! do
    {:ok, conn} = Postgrex.start_link(Wallet.Repo.config())

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      accounts_users,
      blog_articles,
      blog_authors,
      blog_comments,
      blog_favorited_articles,
      blog_feed_articles,
      blog_tags,
      projection_versions
    RESTART IDENTITY;
    """
  end
end
