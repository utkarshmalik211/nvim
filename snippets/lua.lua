local ls = require('luasnip')
local i = ls.i --> insert nodo
local s = ls.s --> snippet
local t = ls.t --> text node

local snippets, autosnippets = {}, {}
local myfirstsnippet = s("sin", {
	t("hi this is a test snippet in lua!"),
	i(1, "placehoder"),
	t("text")
})
table.insert(snippets, myfirstsnippet)
return snippets, autosnippets
