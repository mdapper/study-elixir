defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    # https://hexdocs.pm/elixir/Enum.html#shuffle/1
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    # https://hexdocs.pm/elixir/Enum.html#member?/2
    Enum.member?(deck, hand)
  end

  def deal(deck, hand_size) do
    # https://hexdocs.pm/elixir/Enum.html#split/2
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary deck
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
