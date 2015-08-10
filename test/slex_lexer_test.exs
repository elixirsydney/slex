defmodule SlexLexerTest do
  use ExUnit.Case

  def assert_tokens(input, tokens) do
    {:ok, output, _} = :slex_lexer.string(input)
    assert output == tokens
  end

  test "single element" do
    assert_tokens 'html', [
      { :word,      1, 'html' }
    ]
  end

  test "single element with id" do
    assert_tokens 'div#id', [
      { :word,      1, 'div'  },
      { :id,        1, 'id'   }
    ]
  end

  test "single element with class" do
    assert_tokens 'div.class', [
      { :word,      1, 'div'   },
      { :class,     1, 'class' }
    ]
  end

  test "single element with multiple classes" do
    assert_tokens 'div.c1.c-2', [
      { :word,      1, 'div'   },
      { :class,     1, 'c1'    },
      { :class,     1, 'c-2'   }
    ]
  end

  test "element with one attribute" do
    assert_tokens 'meta a="A"', [
      { :word,      1, 'meta' },
      { :space,     1, ' '    },
      { :word,      1, 'a'    },
      { :equal,     1         },
      { :dbl_quote, 1         },
      { :word,      1, 'A'    },
      { :dbl_quote, 1         }
    ]
  end

  test "element with multiple attributes" do
    assert_tokens 'meta a="A" b="B"', [
      { :word,      1, 'meta' },
      { :space,     1, ' '    },
      { :word,      1, 'a'    },
      { :equal,     1         },
      { :dbl_quote, 1         },
      { :word,      1, 'A'    },
      { :dbl_quote, 1         },
      { :space,     1, ' '    },
      { :word,      1, 'b'    },
      { :equal,     1         },
      { :dbl_quote, 1         },
      { :word,      1, 'B'    },
      { :dbl_quote, 1         }
    ]
  end

  test "indented element" do
    assert_tokens '  div', [
      { :space,     1, '\s\s' },
      { :word,      1, 'div'  }
    ]
  end

  test "nested elements" do
    assert_tokens 'html\n  head', [
      { :word,      1, 'html' },
      { :space,     2, '\s\s' },
      { :word,      2, 'head' }
    ]
  end
end
