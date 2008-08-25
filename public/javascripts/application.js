Terminus = {};

$.extend(MouseApp.Manager, {
    releaseTerm: function() {
      this.activeTerm = null;
    }
  }
);

Terminus.Terminal = function(terminalElement, dialogElement, options) {
  options = $.extend({
    greeting: '%+rt.ermin.us v0.1 %-r',
    ps:       '%+r$%-r'
  }, options);

  this.element         = $(terminalElement);
  this.terminalElement = $(terminalElement);
  this.dialogElement   = $(dialogElement);
  this.setOptions(options);
  this.initWindow();
  this.setup();

  this.dialogElement.hide();

  var $this = this;
  $this.fit();
  $(window).resize(function() { $this.fit(); });
};

$.extend(Terminus.Terminal.prototype, MouseApp.Terminal.prototype, {
  padding: 10, 
  margin:  20,
  border:  5,
  subtractor: function() { return this.padding*2 + this.margin*2 + this.border*2 },
  fit: function() {
    var $this = this;

    var width   = $(window).width();
    var height  = $(window).height();

    var elements = [this.terminalElement, this.dialogElement];
    $(elements).each(function(i) {
      elements[i].width(width - $this.subtractor()); 
      elements[i].height(height - $this.subtractor());

      elements[i].css('padding',      $this.padding+'px');
      elements[i].css('border-width', $this.border+'px');
      elements[i].css('margin',       $this.margin+'px');
    });
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
    } else if ( line == "newcommand" ) {
      this.showModal('/commands/new');
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
    this.terminalElement.find(new_id).html(html);

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
    var scrollHeight = this.terminalElement.attr('scrollHeight');
    var clientHeight = this.terminalElement.attr('clientHeight');
    if ( scrollHeight > clientHeight ) {
        this.terminalElement.attr('scrollTop', scrollHeight - clientHeight);
    }
  },

  showModal: function(url) {
    var $this = this;
    MouseApp.Manager.releaseTerm();
    $.get(url, function(data) {
      $this.dialogElement.html(data);

      $this.terminalElement.slideUp('fast', function() {
        $this.dialogElement.slideDown();
      });
    });
  },

  hideModal: function() {
    var $this = this;
    MouseApp.Manager.observeTerm(this);
    $this.dialogElement.slideUp('fast', function() {
      $this.terminalElement.slideDown();
      $this.prompt();
    });
  }
});
