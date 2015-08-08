defmodule SlexLexerTest do
  use ExUnit.Case

  test "single element on one line" do
    assert :slex_lexer.string('html') ==
      {:ok, [{:element, 1, 'html'}], 1}
  end

  test "nested elements" do
    assert :slex_lexer.string('html\n  head') ==
      {:ok, [
        {:element, 1, 'html'},
        {:space,   2, '\s\s'},
        {:element, 2, 'head'}
      ], 2}
  end
end
