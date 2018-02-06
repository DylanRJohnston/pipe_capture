# PipeCapture

Allows piping to capture.

Based on [elixir-lang-core: Pipe and anonymous functions](https://groups.google.com/d/msg/elixir-lang-core/dwbNOh_yNd4/0MNhVGNvf5QJ)

**Warning:** Never use this in production! Probable not use anywhere else either!

As explained in the thread above, a better solution is to create private
functions to be used in the pipeline. However, piping to capture might
still occasionally be useful in local iex session.

## Installation

Install as mix archive:

```shell
mix archive.install github wojtekmach/pipe_capture
```

Add to `~/.iex.exs`:

```elixir
use PipeCapture

# or on Elixir 1.7+:
use_if_available PipeCapture
```

Start IEx:

```shell
iex -pa $MIX_ARCHIVES/pipe_capture-0.1.0/pipe_capture-0.1.0/ebin/
```

And type

```elixir
iex> 4 |> &Enum.take(1..10, &1)
[1, 2, 3, 4]
```

## License

MIT
