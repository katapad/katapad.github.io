---
title: jadeでmarkdown記法を混ぜたり、coffeescriptを読み込ませたりして、超省力化しよう
date: 2013-06-18
tags: jade
description: MarkdonwやCoffeeScriptはコンパイルしなくても、Jadeにつっこめます
---


[以前の記事](http://jigoku-no.tumblr.com/post/50664376180/grunt-contrib-jade-markdown-htm)で、markdownファイルをゴニョゴニョしてjadeに混ぜよう！みたいなことを言ってたのだけど、ちゃんとしたやりかたがあった。


## jadeのFilterを使うとmarkdownやless, coffeescriptなどを解釈できる

```ruby
def my_cool_method(message)
  puts message
end
```

標準では以下が使えるようになっている。

* `:stylus`
* `:less`
* `:markdown`
* `:cdata`
* `:coffeescript`


使うときは、ちゃんと以下のように使うものをインストールしておく

	`npm install coffee-script`
	

jade側では

	#mdBlock
      :markdown
        # markdownで見出し1

        文章を書きますね。書いてますよ。書いてるんです。書いてるでしょ？書いてるんです！
        
と、書くと出力がこんな感じに。


```html
<div id="mdBlock">
	<h1>markdownで見出し1</h1>
	<p>文章を書きますね。書いてますよ。書いてるんです。書いてるでしょ？書いてるんです！</p>
</div>	
```

	
これはうれしい。

## coffeescriptもインライン展開できる

jadeで

```jade
include /coffee/test.coffee
```
	  
	  
こうすると、test.coffeeをコンパイルしたうえで、展開されてる

```html
<script type="text/javascript">
	(function () {
		console.log('うんこ');
	}).call(this);
</script>
```

jsでPC/スマホ判定リダイレクトを入れるときとかに便利そうだ。




## 以下、gistです

<script src="https://gist.github.com/katapad/5805089.js"></script>

