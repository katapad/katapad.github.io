#= require lib/jquery.min
#= require lib/velocity.min


# sns

do ->
  wrapSpan = (text)->
    text = text.replace(/^\s*/g, '')
    text = text.replace(/\s*$/g, '')
    console.log 'text:', text
    textLength = text.length
    spanText = ''
    for i in [0..textLength]
      letter = text.charAt(i)
      spanText +="<span>#{letter}</span>"
    return spanText

  $('.share__title').each((i, elem)=>
    $elem = $(elem)
    text = $elem.text()
    spanText = wrapSpan(text)
    $elem.html(spanText)
  )


  move = ->
    $('.share__title span').each(->
      $(@).velocity({scale: Math.random() * .5 + 1, rotateZ: Math.random() * 20 - 10}, {duration: 0})
#      $(@).velocity({rotateZ: Math.random() * 40 - 20}, {duration: 0})
    )
    setTimeout(move, 45)

  move()