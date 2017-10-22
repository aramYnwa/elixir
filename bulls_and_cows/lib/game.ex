defmodule Game do
    use GenServer
  
    @max_turns 9
    def max_turns, do: @max_turns
  
    @derive [Poison.Encoder] # This will be used in part 3 to generate JSON
    defstruct [
      turns_left: @max_turns, 
      current_state: :playing, 
      secret: "", 
      last_guess: "", 
      feedback: ""
    ]
  
    def start_link(name \\ Game) do
      GenServer.start_link(__MODULE__, [Secret.new()], name: name)
    end
  
    def submit_guess(pid, guess) do
        GenServer.cast(pid, {:submit_guess, guess})
    end

    def game_state(pid) do
        GenServer.call(pid, :game_state)
    end

    def init([secret]) do
      game = %Game{secret: secret}
      {:ok, game}
    end

    def handle_call(call, _from, state) do
        {:reply, Map.delete(state, :secret), state}
    end

    def handle_cast(cast, state) do
        case cast do 
        {:submit_guess, guess} -> update_state(state, guess)
        end
    end

    def update_state(state, value) do
        case state do
            %{turns_left: turns} when turns == 0 -> {:noreply, state}
            %{turns_left: turns} when turns == 1 -> {:noreply, 
                                                        %{state | 
                                                                last_guess: value,
                                                                turns_left: turns - 1,
                                                                current_state: :lost,
                                                                feedback: BullsAndCows.score_guess(state.secret, value)}}
            %{turns_left: turns} -> {:noreply, 
                                        %{state |
                                                last_guess: value,
                                                turns_left: turns - 1,
                                                feedback: BullsAndCows.score_guess(state.secret, value)}}                                                       
        end   
    end
  end