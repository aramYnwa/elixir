defmodule BullsAndCowsPart3Test do
    use ExUnit.Case
    use Plug.Test
  
    @opts GameRouter.init([])
  
    test "Reports path / is not served by the application" do
      conn = conn(:get, "/")
      conn = GameRouter.call(conn, @opts)
      assert conn.status == 404
      assert conn.resp_body == "Oops"
    end

    test "Post /games" do
      conn = conn(:post, "/games")
      conn = GameRouter.call(conn, @opts)
      assert conn.status == 201
      assert conn.resp_body == "Your game has been created"
    end

    test "Get /games/:id" do
        Game.
        conn = conn(:get, "/games/:id")
        conn = GameRouter.call(conn, @opts)
        assert conn.status == 200
    end
        
  end