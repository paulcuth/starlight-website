local RELEASES_REPO_URL = 'https://github.com/paulcuth/starlight/releases/latest'


return {
  
  index = function (page)
    page:redirect(RELEASES_REPO_URL)
  end

}
