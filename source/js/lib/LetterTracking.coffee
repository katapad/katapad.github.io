class LetterTracking
  constructor: ($target) ->
    $target.each((i, elem)=>
      $elem = $(elem)
      aTag = $elem.find('a');
      if (@hasATag(aTag))
        $elem = aTag

      text = $elem.text()
      spanText = @wrapSpan(text)
      $elem.html(spanText)
    )

  hasATag:(aTag)->
    return aTag.length > 0


  wrapSpan:(text)->
    textLength = text.length
    spanText = ''
    for i in [0..textLength]
      letter = text.charAt(i)
      if (@notLast(i, textLength))
        spanText += @getSpan letter, text.charAt(i + 1)
      else
        spanText += letter
    return spanText

  notLast: (i, textLength)->
    return i <= textLength - 1

  getSpan: (letter, nextString)->
    code = nextString.charCodeAt(0)
    if @isKigou(letter.charCodeAt(0))
      result = "<span class='kigou'>#{letter}</span>"
    else if @isHiraganaOrKatakana(code)
      result = "<span>#{letter}</span>"
    else
      result = letter
    return result

  isHiraganaOrKatakana: (code)->
    return @hiragana(code) || @katakana(code) || @isKigou(code)

  hiragana:(code)->
    return 0x3040 <= code <= 0x309f

  katakana:(code)->
    return 0x30a0 <= code <= 0x30ff

  #いまのところ句読点→、。だけ
  isKigou:(code)->
    return 12289 <= code <= 12290



window.LetterTracking = LetterTracking