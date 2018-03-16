defmodule SlingWeb.Router do
  use SlingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Sling.Auth.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SlingWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", SlingWeb do
    pipe_through [:browser, :auth]

    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  scope "/api", SlingWeb do
    pipe_through [:api, :auth]
    
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/users", UserController
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
  end
end
