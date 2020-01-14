local lorem = require 'lorem'

describe("Lorem test", function()
  describe("Library API test", function()
    it("Check exported functions", function()
      assert.are.equal(type(lorem), 'table')
      assert.are.equal(type(lorem.generator), 'function')
      assert.are.equal(type(lorem.paragraph), 'function')
      assert.are.equal(type(lorem.sentence), 'function')
      assert.are.equal(type(lorem.text), 'function')
      assert.are.equal(type(lorem.word), 'function')
    end)
  end)


  describe("word() test", function()
    it("word() returns string", function()
	    local w = lorem:word()
      assert.are.equal(type(w), 'string')
	  end)
    it("word() consists of lowercase letters ", function()
	    for _ = 1, 20 do
        local w = lorem:word()
        for s in w:gmatch('[a-z]+') do
          assert.are.equal(s, w)
	      end
      end
	  end)
  end)

  describe("sentence() test", function()
	  it("sentence() returns string", function()
	    local s = lorem:sentence()
      assert.are.equal(type(s), 'string')
    end)
    it("sentence() ends with a period", function()
      local s = lorem:sentence()
      assert.are.equal(s:sub(#s, #s), '.')
	  end)
    it("sentence() starts with a capital letter", function()
      local s = lorem:sentence()
      local l = s:sub(1, 1)
      assert.is_true(('A'):byte() <= l:byte())
      assert.is_true(('Z'):byte() >= l:byte())
    end)
  end)

  describe("paragraph() test", function()
    it("paragraph() returns string", function()
      local p = lorem:paragraph()
      assert.are.equal(type(p), 'string')
    end)
    it("paragraph() ends with a period", function()
      local p = lorem:paragraph()
      assert.are.equal(p:sub(#p, #p), '.')
    end)
    it("paragraph() starts with a capital letter", function()
      local p = lorem:paragraph()
      local l = p:sub(1, 1)
      assert.is_true(('A'):byte() <= l:byte())
      assert.is_true(('Z'):byte() >= l:byte())
    end)
    it("paragraph() consists of 2 or more sentences", function()
      local p = lorem:paragraph()
      local s_count = 0
      for _ in p:gmatch('%.') do
        s_count = s_count + 1
      end
      assert.is_true(s_count >= 2)
    end)
  end)

  describe("text() test", function()
    it("text() returns string", function()
      local t = lorem:text()
      assert.are.equal(type(t), 'string')
    end)
    it("text() ends with a period", function()
      local t = lorem:text()
      assert.are.equal(t:sub(#t, #t), '.')
    end)
    it("text() starts with a capital letter", function()
      local t = lorem:text()
      local l = t:sub(1, 1)
      assert.is_true(('A'):byte() <= l:byte())
      assert.is_true(('Z'):byte() >= l:byte())
    end)
    it("text() consists of 2 or more sentences", function()
      local t = lorem:text()
      local s_count = 0
      for _ in t:gmatch('%. ') do
        s_count = s_count + 1
      end
      assert.is_true(s_count >= 1)
    end)
    it("text() consists of 2 or more paragraphs", function()
      local t = lorem:text()
      local p_count = 0
      for _ in t:gmatch('\n') do
        p_count = p_count + 1
      end
      assert.is_true(p_count >= 1)
    end)
  end)

  describe("generator() test", function()
    it("generator(arg) returns table", function()
      local g = lorem:generator('Latin phrase')
      assert.are.equal(type(g), 'table')
    end)
    it("generator() first argument should be a string", function()
      local exp_error = "First argument of lorem.generator should be a string"
      assert.has_error(function() lorem:generator() end, exp_error)
      assert.has_error(function() lorem:generator(3) end, exp_error)
      assert.has_error(function() lorem:generator(true) end, exp_error)
      assert.has_error(function() lorem:generator({}) end, exp_error)
    end)
    it("generator() first argument should contain words", function()
      local exp_error = "String argument of lorem.generator should contain words"
      assert.has_error(function() lorem:generator('') end, exp_error)
      assert.has_error(function() lorem:generator(', =, . _ 323" ^ % / $ # @') end, exp_error)
    end)
    it("generator() check", function()
      local g = lorem:generator('word')
      assert.are.equal(g:word(), 'word')
      assert.is_true(g:sentence():find('Word word word word word(.*).') == 1)
      assert.is_true(g:paragraph():find('Word word word word word(.*). Word word word word word(.*).') == 1)
    end)
  end)

end)
