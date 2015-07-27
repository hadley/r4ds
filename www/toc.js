toc = $("ul#toc");
$("#content").find("h2").each(function() {
  h = $(this);
  toc.append("<li><a href='#" + h.attr("id") + "'>" + h.text() + "</a></li>");
});


$('#nav').affix({
    offset: $('#nav').position()
});