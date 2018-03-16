defmodule SlingWeb.UserView do
  use SlingWeb, :view

  def render("user.json", %{user: user}) do
    %{id: user.id,
      nick: user.nick,
      email: user.email}
  end
end
