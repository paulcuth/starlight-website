local docs = {}
local PAGES = {
  'Embedding Lua in the Web',
  'Interacting with JavaScript',
  'Using Starlight with Grunt'
}

function createSlug (title) 
  title = string.lower(title)
  return string.gsub(title, '[^a-z]', '-')
end


function docs.index(page)
    page:redirect('docs/'..createSlug(PAGES[1]))
end


for _, title in ipairs(PAGES) do
  local name = createSlug(title)

  docs[name] = function (page)
    page.layout = 'left-nav'
    page:render('docs', { name = name, title = title })
  end
end

return docs
