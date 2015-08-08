Definitions.
% Describe AWK-like regex shortcuts to tokens

Space           = [\s]+
Whitespace      = [\t\n]+
Element         = [a-z]+
Id              = #[a-z]+
Class           = \.[a-z]+


Rules.
% Describe how tokens are generated

{Space}         : {token, {space,  TokenLine, TokenChars}}.
{Element}       : {token, {element, TokenLine, TokenChars}}.
{Whitespace}+   : skip_token.

Erlang code.

% Put erlang code here
