<?lua
  if name then
    local md = require('sailor.md')
    md.include('views/docs/md/'..name..'.md')
  end
?>
