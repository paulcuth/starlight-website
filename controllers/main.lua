local main = {}

function main.index(page)
    page:render('index', { pageId = 'home' })
end

return main
