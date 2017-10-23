defmodule Takso.BookingController do
  use Takso.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end
