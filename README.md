jQuery-enabled Clippy - Helping you copy text to your clipboard
===============================================================

Source Code: http://github.com/mockko/clippy
Modified By: Andrey Tarantsov <andreyvit@gmail.com>
Based On:    http://github.com/mojombo/clippy

This version of Clippy makes friends with (and requires) jQuery. Only the button is displayed; showing “copy to clipboard” and “copied!” texts is up to the user.

Here's the code I use to insert Clippy:

    var $copy = $('#copy-button'), $copyLabel = $('#copy-button-label');
    $copy.clippy('/static/clippy-mockko.swf').bind({
      'clippycopy': function(e, data) {
        data.text = getRunURL();
      },
      'clippyover': function() {
        $copyLabel.html("copy to clipboard");
      },
      'clippyout': function() {
        $copyLabel.html("");
      },
      'clippycopied': function() {
        $copyLabel.html("copied!");
      }
    });

Clippy accepts a single FlashVar called `target` and uses `$.trigger` to trigger the following events on it: `clippycopy` (return the text to copy), `clippyover` (button hovered), `clippyout` (button unhovered), `clippycopied` (button clicked).

Here is the jQuery plugin:

    $.fn.clippy = function(url) {
      return $(this).embedflash({
        width: 14,
        height: 14,
        url: url,
        vars: {
          target: this.selector
        }
      });
    };

    $.fn.embedflash = function(options) {
      var vars = (function() {
        var result = [], _vars = options.vars || {}, k;
        for (k in _vars) {
          if (!_vars.hasOwnProperty(k)) continue;
          result.push("" + (escape(k)) + "=" + (escape(_vars[k])));
        }
        return result;
      })().join("&");
      return $(this).html("<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" width=\"" + (options.width) + "\" height=\"" + (options.height) + "\"> <param name=\"movie\" value=\"" + (escape(options.url)) + "\"/> <param name=\"allowScriptAccess\" value=\"always\" /> <param name=\"quality\" value=\"high\" /> <param name=\"wmode\" value=\"transparent\"/> <param name=\"scale\" value=\"noscale\" /> <param name=\"FlashVars\" value=\"" + (vars) + "\"> <embed src=\"" + (escape(options.url)) + "\" width=\"" + (options.width) + "\" height=\"" + (options.height) + "\" quality=\"high\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" FlashVars=\"" + (vars) + "\" wmode=\"transparent\" /> </object>");
    };

This code has actually been compiled from the following CoffeeScript:

    $copy.clippy('/static/clippy-mockko.swf').bind
      'clippycopy':   (e, data) ->  data.text = getRunURL()
      'clippyover':   ->            $copyLabel.html "copy to clipboard"
      'clippyout':    ->            $copyLabel.html ""
      'clippycopied': ->            $copyLabel.html "copied!"

    $.fn.clippy = (url) ->
      this.embedflash width: 14, height: 14, url, vars: { target: @selector }

    $.fn.embedflash = (options) ->
      { width, height, url } = options  # mandatory

      vars = ("#{escape(k)}=#{escape(v)}" for k, v of options.vars || {}).join("&")

      this.html("""<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="#{width}" height="#{height}"> <param name="movie" value="#{escape(url)}"/> <param name="allowScriptAccess" value="always" /> <param name="quality" value="high" /> <param name="wmode" value="transparent"/> <param name="scale" value="noscale" /> <param name="FlashVars" value="#{vars}"> <embed src="#{escape(url)}" width="#{width}" height="#{height}" quality="high" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" FlashVars="#{vars}" wmode="transparent" /> </object>""")


Installation (Pre-Built SWF)
---------------------------

If you want to use Clippy unmodified, just copy `build/clippy.swf` to your
`public` directory or wherever your static assets can be found.

Installation (Compiling)
------------------------

In order to compile Clippy from source, you need to install the following:

* [haXe](http://haxe.org/)
* [swfmill](http://swfmill.org/)

The haXe code is in `clippy.hx`, the button images are in `assets`, and the
compiler config is in `compile.hxml`. Make sure you look at all of these to
see where and what you'll need to modify. To compile everything into a final
SWF, run the following from Clippy's root directory:

    swfmill simple library.xml library.swf && haxe compile.hxml

If that is successful, copy `build/clippy.swf` to your
`public` directory or wherever your static assets can be found.

Please note that I haven't been able to build a working SWF using haXe 2.06
on OS X. Using haXe 2.05 works fine.

Contribute
----------

If you'd like to hack on Clippy, start by forking my repo on GitHub:

http://github.com/mojombo/clippy

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a topic branch to contain your change
1. Hack away
1. If you are adding new functionality, document it in README.md
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send me (mojombo) a pull request for your branch

License
-------

MIT License (see LICENSE file)
