local docs = {}
local PAGES = {
  'embedding-lua-in-the-web',
  'interacting-with-javascript',
  'usage-with-grunt'
}


function docs.index(page)
    page:render('docs', { name = PAGES[1] })
end

for _, name in ipairs(PAGES) do
  docs[name] = function (page)
    page.layout = 'left-nav';
    page:render('docs', { name = name });
  end
end

return docs
