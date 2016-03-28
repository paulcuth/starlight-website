local EXAMPLES_REPO_URL = 'https://github.com/paulcuth/starlight-examples'


return {
  
  index = function (page)
    page:redirect(EXAMPLES_REPO_URL)
  end

}
