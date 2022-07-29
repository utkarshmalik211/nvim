local ls = require('luasnip')
local i = ls.i --> insert nodo
local s = ls.s --> snippet
local t = ls.t --> text node

local snippets, autosnippets = {}, {}

local myfirstsnippet = s("snippet", { t("hi this is a test snippet in lua!") })
table.insert(snippets, myfirstsnippet)

return snippets, autosnippets
