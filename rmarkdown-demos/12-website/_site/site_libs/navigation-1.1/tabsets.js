

window.buildTabsets = function(tocID) {

  // build a tabset from a section div with the .tabset class
  function buildTabset(tabset) {

    // check for fade and pills options
    var fade = tabset.hasClass("tabset-fade");
    var pills = tabset.hasClass("tabset-pills");
    var navClass = pills ? "nav-pills" : "nav-tabs";

    // determine the heading level of the tabset and tabs
    var match = tabset.attr('class').match(/level(\d) /);
    if (match === null)
      return;
    var tabsetLevel = Number(match[1]);
    var tabLevel = tabsetLevel + 1;

    // find all subheadings immediately below
    var tabs = tabset.find("div.section.level" + tabLevel);
    if (!tabs.length)
      return;

    // create tablist and tab-content elements
    var tabList = $('<ul class="nav ' + navClass + '" role="tablist"></ul>');
    $(tabs[0]).before(tabList);
    var tabContent = $('<div class="tab-content"></div>');
    $(tabs[0]).before(tabContent);

    // build the tabset
    tabs.each(function(i) {

      // get the tab div
      var tab = $(tabs[i]);

      // get the id then sanitize it for use with bootstrap tabs
      var id = tab.attr('id');

      // remove any table of contents entries associated with
      // this ID (since we'll be removing the heading element)
      $("div#" + tocID + " li a[href='#" + id + "']").parent().remove();

      // sanitize the id for use with bootstrap tabs
      id = id.replace(/[.\/?&!#<>]/g, '').replace(/\s/g, '_');
      tab.attr('id', id);

      // get the heading element within it, grab it's text, then remove it
      var heading = tab.find('h' + tabLevel + ':first');
      var headingText = heading.html();
      heading.remove();

      // build and append the tab list item
      var a = $('<a role="tab" data-toggle="tab">' + headingText + '</a>');
      a.attr('href', '#' + id);
      a.attr('aria-controls', id);
      var li = $('<li role="presentation"></li>');
      li.append(a);
      if (i === 0)
        li.attr('class', 'active');
      tabList.append(li);

      // set it's attributes
      tab.attr('role', 'tabpanel');
      tab.addClass('tab-pane');
      tab.addClass('tabbed-pane');
      if (fade)
        tab.addClass('fade');
      if (i === 0) {
        tab.addClass('active');
        if (fade)
          tab.addClass('in');
      }

      // move it into the tab content div
      tab.detach().appendTo(tabContent);
    });
  }

  // convert section divs with the .tabset class to tabsets
  var tabsets = $("div.section.tabset");
  tabsets.each(function(i) {
    buildTabset($(tabsets[i]));
  });
};

