local main = {}

function main.index(page)
    page.layout = 'home'
    page:render('index')
end

return main
