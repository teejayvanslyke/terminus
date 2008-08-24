Webterm = {};
Webterm.Terminal = function(element, options) {
  options = $.extend({
    greeting: '%+rt.ermin.us v0.1 %-r',
    ps:       '%+r$%-r'
  }, options);

  this.element = $(element);
  this.setOptions(options);
  this.initWindow();
  this.setup();

  var $this = this;
  $this.fit();
  $(window).resize(function() { $this.fit(); });

};

$.extend(Webterm.Terminal.prototype, MouseApp.Terminal.prototype, {
  fit: function() {
    var padding = 10;
    var margin  = 20;
    var border  = 5;
    
    var subtractor = padding*2 + margin*2 + border*2;

    var width   = $(window).width();
    var height  = $(window).height();
    this.element.width(width - subtractor); 
    this.element.height(height - subtractor);

    this.element.css('padding',      padding+'px');
    this.element.css('border-width', border+'px');
    this.element.css('margin',       margin+'px');
  },

  onKeyEnter: function() {
      var cmd = this.getCommand();
      if (cmd) {
          this.history[this.historyNum] = cmd;
          this.backupNum = ++this.historyNum;
      }
      this.commandNum++;
      this.advanceLine();
      if (cmd) {
          this.onCommand(cmd);
      }
  },

  onCommand: function(line) {
    var terminal = this;
    if ( line == "clear" ) {
        this.clear();
        this.prompt();
    } else if ( line == "reload" ) {
      window.location.reload();
    } else {
      args    = line.split(' ');
      id      = args[0];
      params = [];
      for (arg in args) {
        if (arg!=0) {
          params.push(args[arg]);
        }
      }
      $.get('/commands/show/'+id, {'args[]': params}, function(str) {
        if (str) {
            if ( str.substr(str.length - 1, 1) != "\n" ) {
                str += "\n";
            }
            terminal.writeHTML(str);
            terminal.prompt();
        }
      });
    }
  },
  writeHTML: function(html) {
    var new_id = '#terminal_' + (this.rpos++);
    this.element.find(new_id).html(html);

    // Callbacks
    var $this = this;
    $('a.execute').click(function() {
      var command = $(this).attr('href').substr(1);
      $this.onCommand(command);
    });

    this.advanceLine();
    this.scrollAllTheWayDown();
  },
    
  scrollAllTheWayDown: function() {
    var scrollHeight = this.element.attr('scrollHeight');
    var clientHeight = this.element.attr('clientHeight');
    if ( scrollHeight > clientHeight ) {
        this.element.attr('scrollTop', scrollHeight - clientHeight);
    }
  }

});

