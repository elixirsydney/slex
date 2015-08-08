% Describe AWK-like regex shortcuts to tokens

% Questions:

% - How do we treat indents differently?
%   How best to anchor to a line start?
%     leex apparently does not support this

% - How to differentiate between element defn v attr key or value
%   What is the order of precedence for overlapping regex matching?
%     could solve if this is given

Definitions.

Space           = [\s]+
Whitespace      = [\t\n]+
Word            = [a-zA-Z]+
Id              = #[a-z][-a-z0-9]+
Class           = \.[a-z][-a-z0-9]+
Equal           = =
DblQuote        = "

% Describe how tokens are generated

Rules.

{Space}         : {token, {space,  TokenLine, TokenChars}}.
{Word}          : {token, {word, TokenLine, TokenChars}}.
{Id}            : {token, {id, TokenLine, to_id(TokenChars)}}.
{Class}         : {token, {class, TokenLine, to_class(TokenChars)}}.
{Equal}         : {token, {equal, TokenLine}}.
{DblQuote}      : {token, {dbl_quote, TokenLine}}.
{Whitespace}+   : skip_token.


% Token processing code

Erlang code.

to_id([$#|Chars]) ->
  Chars.

to_class([$.|Chars]) ->
  Chars.
