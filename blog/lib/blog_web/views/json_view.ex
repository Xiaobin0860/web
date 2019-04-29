defmodule BlogWeb.JsonView do
  use BlogWeb, :view
  alias BlogWeb.JsonView

  def render("index.json", %{jsons: jsons}) do
    %{data: render_many(jsons, JsonView, "json.json")}
  end

  def render("show.json", %{json: json}) do
    %{data: render_one(json, JsonView, "json.json")}
  end

  def render("json.json", %{json: json}) do
    %{id: json.id,
      test: json.test}
  end
end
