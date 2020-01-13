local lorem = {}

local WORDS_IN_SENTENCE      = {min = 5, max = 15}
local SENTENCES_IN_PARAGRAPH = {min = 2, max = 7 }
local PARAGRAPHS_IN_TEXT     = {min = 2, max = 7 }

local function random_int(min, max)
    return math.random(min, max)
end

lorem.__index = lorem
lorem.DATA = {
    --luacheck: no max code line length
    "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit", "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore", "magna", "aliqua", "ut", "enim", "ad", "minim", "veniam", "quis", "nostrud", "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo", "consequat", "duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla", "pariatur", "excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum"
}

function lorem:generator(phrase)
    if type(phrase) ~= 'string' then
        error('First argument of lorem.generator should be a string', 2)
    end
    local g = {DATA = {}}
    for word in phrase:gmatch('%a+') do
        table.insert(g.DATA, word:lower())
    end
    if #(g.DATA) == 0 then
        error('String argument of lorem.generator should contain words', 2)
    end
    setmetatable(g, self)
    return g
end

function lorem:word()
    return self.DATA[random_int(1, #(self.DATA))]
end

function lorem:sentence()
    local n = random_int(WORDS_IN_SENTENCE.min, WORDS_IN_SENTENCE.max)
    local words = {}
    for i = 1, n do
        words[i] = self:word()
    end
    local s = table.concat(words, ' ')
    s = s .. "."
    s = s:sub(1, 1):upper() .. s:sub(2)
    return s
end

function lorem:paragraph()
    local n = random_int(SENTENCES_IN_PARAGRAPH.min, SENTENCES_IN_PARAGRAPH.max)
    local sentences = {}
    for i = 1, n do
        sentences[i] = self:sentence()
    end
    return table.concat(sentences, ' ')
end

function lorem:text()
    local n = random_int(PARAGRAPHS_IN_TEXT.min, PARAGRAPHS_IN_TEXT.max)
    local paragraphs = {}
    for i = 1, n do
        paragraphs[i] = self:paragraph()
    end
    return table.concat(paragraphs, '\n')
end

return lorem
