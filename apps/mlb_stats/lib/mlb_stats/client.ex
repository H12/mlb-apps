defmodule MLBStats.Client do
  @moduledoc """
  A Tesla client for fetching data from MLB's Stats API
  """
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://statsapi.mlb.com/api/v1")
  plug(Tesla.Middleware.JSON, engine_opts: [keys: :atoms])

  @doc """
  Given a valid pk (a game's unique id), fetches the live feed for that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572")
      iex> status
      200

  """
  def game_feed(game_pk) do
    get("/game/" <> game_pk <> "/feed/live") |> handle_response
  end

  @doc """
  Given a valid pk (a game's unique id) and an array of fields, fetches the filtered live feed data
  for that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572")
      iex> status
      200

  """
  def game_feed(game_pk, fields) do
    get("/game/" <> game_pk <> "/feed/live" <> "?fields=" <> Enum.join(fields, ","))
    |> handle_response
  end

  @doc """
  Given a valid pk (a game's unique id), fetches the linescore for that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572")
      iex> status
      200

  """
  def game_linescore(game_pk) do
    get("/game/" <> game_pk <> "/linescore") |> handle_response
  end

  @doc """
  Given a valid pk (a game's unique id) and an array of fields, fetches the filtered linescore for
  that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572", ["innings", "home", "away", "runs"])
      iex> status
      200

  """
  def game_linescore(game_pk, fields) do
    get("/game/" <> game_pk <> "/linescore" <> "?fields=" <> Enum.join(fields, ","))
    |> handle_response
  end

  @doc """
  Given a valid pk (a game's unique id), fetches the play-by-play for that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572")
      iex> status
      200

  """
  def game_play_by_play(game_pk) do
    get("/game/" <> game_pk <> "/playByPlay") |> handle_response
  end

  @doc """
  Given a valid pk (a game's unique id) and an array of fields, fetches the filtered play-by-play
  data for that game.

  ## Examples

      iex> %{status: status} = MLBStats.Client.game_feed("529572")
      iex> status
      200

  """
  def game_play_by_play(game_pk, fields) do
    get("/game/" <> game_pk <> "/playByPlay" <> "?fields=" <> Enum.join(fields, ","))
    |> handle_response
  end

  @doc """
  Fetches the MLB schedule for the current date.

  ## Examples

      iex> %{status: status} = MLBStats.Client.daily_schedule()
      iex> status
      200

  """
  def daily_schedule() do
    get("/schedule/" <> "?sportId=1") |> handle_response
  end

  @doc """
  Fetches the MLB schedule for a given date String, of format "yyyy-mm-dd".

  ## Examples

      iex> %{status: status} = MLBStats.Client.daily_schedule("2019-06-08")
      iex> status
      200

  """
  def daily_schedule(date) do
    get("/schedule/" <> "?sportId=1" <> "&date=" <> date) |> handle_response
  end

  @doc """
  Fetches a filtered MLB schedule for a given date String, of format "yyyy-mm-dd", and an array of
  fields.

  ## Examples

      iex> %{status: status} = MLBStats.Client.daily_schedule("2019-06-08")
      iex> status
      200

  """
  def daily_schedule(date, fields) do
    get("/schedule/" <> "?sportId=1" <> "&date=" <> date <> "&fields=" <> Enum.join(fields, ","))
    |> handle_response
  end

  @doc """
  Fetches the MLB schedule for a range of dates given two date Strings of format "yyyy-mm-dd" which
  denote the start and end dates of the range.


  ## Examples

    iex> %{status: status} = MLBStats.Client.ranged_schedule("2019-06-01", "2019-6-30")
    iex> status
    200

  """
  def ranged_schedule(start_date, end_date) do
    get("/schedule/" <> "?sportId=1" <> "&startDate=" <> start_date <> "&endDate=" <> end_date)
    |> handle_response
  end

  @doc """
  Fetches a filtered MLB schedule for a range of dates given two date Strings of format "yyyy-mm-dd" which
  denote the start and end dates of the range, and a list of fields.


  ## Examples

    iex> %{status: status} = MLBStats.Client.ranged_schedule("2019-06-01", "2019-6-30")
    iex> status
    200

  """
  def ranged_schedule(start_date, end_date, fields) do
    get(
      "/schedule/" <>
        "?sportId=1" <>
        "&startDate=" <>
        start_date <> "&endDate=" <> end_date <> "&fields=" <> Enum.join(fields, ",")
    )
    |> handle_response
  end

  defp handle_response({:ok, response}), do: response
  defp handle_response({:error, response}), do: response
  defp handle_response({:timeout, response}), do: response
end
