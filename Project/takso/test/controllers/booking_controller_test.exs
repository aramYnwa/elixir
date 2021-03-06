defmodule Takso.BookingControllerTest do
    use Takso.ConnCase
    alias Takso.{Taxi, Repo}
  
    test "Booking with rejection", %{conn: conn} do
        [%{username: "juhan", location: "Kaubamaja", status: "busy"}]
        |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
        |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
        conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
        conn = get conn, redirected_to(conn)
        assert html_response(conn, 200) =~ ~r/Our appologies, we cannot serve your request at this moment/
    end


    test "Booking with confirmation", %{conn: conn} do
        [%{username: "juhan", location: "Kaubamaja", status: "available"}]
        |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
        |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
        conn = post conn, "/bookings", %{booking: [pickup_address: "Liivi 2", dropoff_address: "Lõunakeskus"]}
        conn = get conn, redirected_to(conn)
        assert html_response(conn, 200) =~ ~r/Your taxi will arrive in \d+ minutes/
    end
  end