defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Hello.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", HelloWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messager", HelloController, :hello
    resources "/users", UserController
    get "/chat", ChatController, :index
  end

  scope "/react", HelloWeb do
    pipe_through :browser

    get "/*path", ReactController, :index
  end

  scope "/pm", HelloWeb do
    pipe_through [:browser, :auth]

    get "/", PmController, :index
    post "/", PmController, :login
    post "/logout", PmController, :logout
  end
  scope "/pm", HelloWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", PmController, :secret
  end
end
