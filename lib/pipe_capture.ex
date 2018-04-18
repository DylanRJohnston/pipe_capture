defmodule PipeCapture do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [|>: 2]
      import PipeCapture
    end
  end

  @doc """
  `Kernel.|>/2` extended to support `Kernel.SpecialForms.&` captures.

  ## Examples

      iex> import Kernel, except: [|>: 2]
      iex> import PipeCapture
      iex> 4 |> &Enum.take(1..10, &1)
      [1, 2, 3, 4]

  """
  defmacro left |> right do
    [{h, _} | t] = Macro.unpipe({:|>, [], [left, right]})

    fun = fn {x, pos}, acc ->
      case x do
        {op, _, [_]} when op == :+ or op == :- ->
          :elixir_errors.warn(__CALLER__.line, __CALLER__.file, <<
            "piping into a unary operator is deprecated, please use the ",
            "qualified name. For example, Kernel.+(5), instead of +5"
          >>)

        _ ->
          :ok
      end

      pipe(acc, x, pos)
    end

    :lists.foldl(fun, h, t)
  end

  defp pipe(expr, {:&, _, _} = call_args, position) do
    Macro.pipe(expr, {{:., [], [call_args]}, [], []}, position)
  end
  
  defp pipe(expr, {:fn, _, _} = call_args, position) do
    Macro.pipe(expr, {{:., [], [call_args]}, [], []}, position)
  end

  defp pipe(expr, call, position), do: Macro.pipe(expr, call, position)
end
