(function(jQuery) {

    jQuery.fn.clippy = function(url, target) {
      return jQuery(this).embedflash({
        width: 14,
        height: 14,
        url: url,
        vars: {
          text: jQuery(this).html(),
          target: target
        }
      });
    };

    jQuery.fn.embedflash = function(options) {
      var vars = (function() {
        var result = [], _vars = options.vars || {}, k;
        for (k in _vars) {
          if (!_vars.hasOwnProperty(k)) continue;
          result.push("" + (escape(k)) + "=" + (escape(_vars[k])));
        }
        return result;
      })().join("&");
      return jQuery(this).html("<object id=\"clippy_swf_"+options.vars.target+"\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" width=\"" + (options.width) + "\" height=\"" + (options.height) + "\"> <param name=\"movie\" value=\"
" + (escape(options.url)) + "\"/> <param name=\"allowScriptAccess\" value=\"always\" /> <param name=\"quality\" value=\"high\" /> <param name=\"wmode\" value=\"transparent\"/> <param name=\"scale\" value=\"noscale\" /> <param name=\"Flash
Vars\" value=\"" + (vars) + "\"> <embed src=\"" + (escape(options.url)) + "\" width=\"" + (options.width) + "\" height=\"" + (options.height) + "\" quality=\"high\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" plugi
nspage=\"http://www.macromedia.com/go/getflashplayer\" FlashVars=\"" + (vars) + "\" wmode=\"transparent\" /> </object>");
    };

})(jQuery);
