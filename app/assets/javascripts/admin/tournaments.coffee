initialize '#article-scrape', ->
  $articleUrlInput = $('input#team_article_url')
  $previewInput = $('textarea#team_preview')
  $error = $(this).find('.error')
  $(this).find('a').on 'click', (e) ->
    articleUrl = $articleUrlInput.val()
    if not articleUrl
      return
    errorTimer = setTimeout( ->
      console.log('hello')
      $error.text('Unable to retrieve body text. Check to make sure the URL is valid?')
    , 2000)
    $.get({
      url: "#{articleUrl}.json",
      dataType: 'jsonp',
    })
      .done (data) ->
        $previewInput.val(unescape(data.article.copy))
        clearTimeout(errorTimer)
