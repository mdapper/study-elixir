# Section 01 - Elixir Warmup

## Mix

- Create a project
- Compile projects
- Run tasks
- Manage dependencies

### Create

```bash
mix new cards
```

That creates the `cards` folder with initial project.

### Run the code

Inside `cards` folder run:

```bash
iex -S mix
```

The flag `-S` compiles our project.

To access our module we can run `Cards`, and to run our `hello` method we can do `Cards.hello`.

To recompile our code inside `iex` we can run `recompile`.

## Lists and Strings

### String

```elixir
def hello do
  "Hello world!"
end
```

We can use single quote, but the convention is to use double quotes for all strings.

### Lists

```elixir
def create_deck do
  ["Ace", "Two", "Three", "Four"]
end
```

## OO vs Functional programing

### Object approach:

![OO Approach](../assets/01-oo-approach.png)

```ts
class Card {
  suit: string;
  value: string;

  constructor(suit: string, value: string) {
    this.suit = suit;
    this.value = value;
  }
}
```

```ts
class Deck {
  cards: Array<string>;
  constructor(cards: Array<string>) {
    this.cards = cards;
  }

  shuffle() {
    // Shuffle this.cards property
  }
  save() {}
  load() {}
}
```

We need to create a class instance to operate on it's values:

```ts
const cards = ['Ace', 'Two', 'Three'];
const deck = new Deck(cards); // Create Deck instance

deck.cards; // Gets the original array ["Ace", "Two", "Three"]
deck.shuffle(); // Shuffle the local cards property
deck.cards; // Now our cards property got mutated
```

### FP Approach:

![FP Approach](../assets/02-fp-approach.png)

Here we don't have classes and the concept of `instance` of a class.

We have data structures, methods that accept them and output new data structures, they don't mutate the original ones.

Here we have a `create_deck` method that returns a list of cards:

```elixir
defmodule Cards do
  def create_deck do
    ["Ace", "Two", "Three", "Four"]
  end
end
```

## Creating new methods

In elixir we can have different methods with the same name, but only change our params types or quantity:

```elixir
defmodule Cards do
  def shuffle do
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
end
```

Then we could run them inside `iex` with:

```elixir
Cards.shuffle
Cards.shuffle(["Ace"])
```

The code above is valid.

## Immutability

Given the code:

```elixir
defmodule Cards do
  def create_deck do
    ["Ace", "Two", "Three", "Four"]
  end

  def shuffle(deck) do
    # https://hexdocs.pm/elixir/Enum.html#shuffle/1
    Enum.shuffle(deck)
  end
end
```

Then we could run inside `iex`:

```elixir
# create cards list
cards = Cards.create_deck

# shuffle it
Cards.shuffle(cards)

# cards will still be the original list
cards
```

Our `cards` variable is immutable.

![Cards Module](../assets/03-immutability.png)

What happen is that shuffle first copy the list, then shuffle the copy and return it. The original variable was never changed.

## Search a list

By convention if a method contain `?` it will return `true` or `false`:

```elixir
defmodule Cards do
  # ...

  def contains?(deck, hand) do
    # https://hexdocs.pm/elixir/Enum.html#member?/2
    Enum.member?(deck, hand)
  end
end
```

Inside `iex` run:

```elixir
deck = Cards.create_deck

# search
Cards.contains?(deck, "Two") # true
Cards.contains?(deck, "King") # false
```

![Contains](../assets/04-contains.png)

## Comprehensions Over Lists

We can use a `for` loop for that:

```elixir
def create_deck do
  values = ["Ace", "Two", "Three", "Four", "Five"]
  suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

  for suit <- suits do
    suit
  end
end
```

The `for` will create a new map with each `suit` value.

At first we could think on doing something like this:

```elixir
for value <- values do
  for suit <- suits do
    "#{value} of #{suit}"
  end
end
```

But with this we get one array for each suit:

```
[
  ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
   "Five of Spades"],
  ["Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs",
   "Five of Clubs"],
  ["Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
   "Five of Hearts"],
  ["Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
   "Four of Diamonds", "Five of Diamonds"]
]
```

If we want only one list we can use [List.flatten](https://hexdocs.pm/elixir/List.html#flatten/1):

```elixir
cards = for value <- values do
  for suit <- suits do
    "#{value} of #{suit}"
  end
end
List.flatten(cards)
```

Or a better way is to use:

```elixir
for suit <- suits, value <- values do
  "#{value} of #{suit}"
end
```

## Tuples

![Deal](../assets/05-deal.png)

```elixir
def deal(deck, hand_size) do
  # https://hexdocs.pm/elixir/Enum.html#split/2
  Enum.split(deck, hand_size)
end
```

The `Enum.split` will return a tuple.

![Tuple](../assets/06-tuple.png)

In the next session we will see how to access each element of the tuple.
